<?php
// إعدادات الاستجابة لضمان استقبال JSON بشكل صحيح ودعم اللغة العربية
header("Content-Type: application/json; charset=utf-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// 1. معلومات الاتصال بقاعدة البيانات
$conn = include __DIR__ . '/db_connect.php';

if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "فشل الاتصال بقاعدة البيانات: " . $conn->connect_error]));
}
$conn->set_charset("utf8");

// 2. التأكد من أن الطلب هو POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    die(json_encode(["success" => false, "message" => "طريقة الطلب غير صالحة."]));
}

// 3. استقبال البيانات من جسم الطلب (JSON)
$data = json_decode(file_get_contents("php://input"), true);

// تعيين المتغيرات من البيانات المستقبلة
$user_id = $data['user_id'] ?? null;
$service_id = $data['service_id'] ?? null; // تم التغيير من service_name
$bank_id = $data['bank_id'] ?? null;
$user_account_number = $data['user_account_number'] ?? null;
$user_password = $data['user_password'] ?? null;
$amount = $data['amount'] ?? null; // هذا هو total_amount

// التحقق من أن جميع البيانات المطلوبة موجودة وليست فارغة
if (is_null($user_id) || is_null($service_id) || is_null($bank_id) || is_null($user_account_number) || is_null($user_password) || is_null($amount)) {
    die(json_encode(["success" => false, "message" => "يوجد نقص في الحقول المطلوبة. تأكد من إرسال user_id, service_id, bank_id, user_account_number, user_password, amount."]));
}

// 4. بدء المعاملة (Transaction) لضمان سلامة جميع العمليات
$conn->begin_transaction();

try {
    // 5. التحقق من حساب المستخدم ورصيده (مع قفل الصف للتحديث لمنع التضارب)
    $stmt_user = $conn->prepare("SELECT user_account_id, balance FROM useraccounts WHERE account_number = ? AND account_password = ? AND bank_id = ? FOR UPDATE");
    $stmt_user->bind_param("ssi", $user_account_number, $user_password, $bank_id);
    $stmt_user->execute();
    $result_user = $stmt_user->get_result();

    if ($result_user->num_rows == 0) {
        throw new Exception("بيانات حساب المستخدم أو كلمة المرور غير صحيحة.");
    }

    $user_account = $result_user->fetch_assoc();
    if ($user_account['balance'] < $amount) {
        throw new Exception("الرصيد في حسابك غير كافٍ لإتمام هذه العملية.");
    }
    $stmt_user->close();

    // 6. جلب provider_id من جدول provideraccounts (حساب الشركة)
    $stmt_provider = $conn->prepare("SELECT provider_id FROM provideraccounts WHERE bank_id = ? LIMIT 1");
    $stmt_provider->bind_param("i", $bank_id);
    $stmt_provider->execute();
    $result_provider = $stmt_provider->get_result();

    if ($result_provider->num_rows == 0) {
        throw new Exception("خطأ: لا يوجد حساب للشركة مسجل في هذا البنك.");
    }
    $provider_data = $result_provider->fetch_assoc();
    $provider_id = $provider_data['provider_id'];
    $stmt_provider->close();

    // 7. تنفيذ التحويل المالي
    // خصم المبلغ من حساب المستخدم
    $stmt_debit = $conn->prepare("UPDATE useraccounts SET balance = balance - ? WHERE account_number = ? AND bank_id = ?");
    $stmt_debit->bind_param("dsi", $amount, $user_account_number, $bank_id);
    $stmt_debit->execute();
    $stmt_debit->close();

    // إضافة المبلغ إلى حساب الشركة
    $stmt_credit = $conn->prepare("UPDATE provideraccounts SET balance = balance + ? WHERE bank_id = ?");
    $stmt_credit->bind_param("di", $amount, $bank_id);
    $stmt_credit->execute();
    $stmt_credit->close();

    // 8. إنشاء سجل الحجز في جدول bookings (باستخدام الأعمدة الصحيحة)
    $status = "Confirmed"; // الحالة دائماً ستكون مؤكدة بعد الدفع

    $stmt_booking = $conn->prepare("INSERT INTO bookings (user_id, service_id, provider_id, total_amount, status) VALUES (?, ?, ?, ?, ?)");
    // التحقق من نجاح الـ prepare
    if ($stmt_booking === false) {
        throw new Exception("فشل في تحضير جملة إضافة الحجز: " . $conn->error);
    }
    $stmt_booking->bind_param("iiids", $user_id, $service_id, $provider_id, $amount, $status);
    $stmt_booking->execute();
    $booking_id = $stmt_booking->insert_id; // الحصول على ID الحجز الجديد
    $stmt_booking->close();

    // 9. تأكيد المعاملة (حفظ كل التغييرات بشكل دائم)
    $conn->commit();

    // 10. إرسال استجابة النجاح النهائية
    echo json_encode([
        "success" => true,
        "message" => "تم الدفع بنجاح وتأكيد الحجز.",
        "booking_id" => $booking_id
    ]);

} catch (Exception $e) {
    // 11. في حالة حدوث أي خطأ، يتم التراجع عن كل العمليات السابقة
    $conn->rollback();
    // إرسال استجابة الفشل مع رسالة الخطأ الواضحة
    http_response_code(400 ); // Bad Request
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}

$conn->close();
?>
