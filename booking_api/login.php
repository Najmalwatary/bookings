<?php
// -----------------------------------------------------------------------------
// 1. إعدادات CORS (Cross-Origin Resource Sharing)
// -----------------------------------------------------------------------------
// السماح بالطلبات من أي مصدر (لأغراض التطوير)
header("Access-Control-Allow-Origin: *");
// تحديد الطرق (HTTP Methods) المسموح بها
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
// تحديد الترويسات (HTTP Headers) المسموح بها في الطلب
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// -----------------------------------------------------------------------------
// 2. التعامل مع طلبات OPTIONS الأولية (Preflight Requests)
// -----------------------------------------------------------------------------
// عندما يرسل تطبيق (مثل Flutter) طلباً معقداً، يرسل أولاً طلب OPTIONS
// للتحقق من أن الخادم يسمح بالطلب الفعلي.
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // نرسل استجابة "204 No Content" وننهي التنفيذ.
    // هذا يخبر التطبيق "نعم، يمكنك المتابعة وإرسال طلب POST".
    http_response_code(204 );
    exit();
}

// -----------------------------------------------------------------------------
// 3. التحقق من أن الطلب الفعلي هو POST
// -----------------------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    // إذا كان الطلب ليس POST، نرسل خطأ "405 Method Not Allowed".
    http_response_code(405 );
    echo json_encode(["success" => false, "message" => "Invalid request method. Only POST is accepted."]);
    exit();
}

// -----------------------------------------------------------------------------
// 4. تضمين ملف الاتصال بقاعدة البيانات
// -----------------------------------------------------------------------------
$conn = include __DIR__ . '/db_connect.php';

// التحقق من نجاح الاتصال
if (!$conn) {
    http_response_code(500 ); // Internal Server Error
    echo json_encode(["success" => false, "message" => "Database connection failed."]);
    exit();
}

// -----------------------------------------------------------------------------
// 5. منطق تسجيل الدخول
// -----------------------------------------------------------------------------
try {
    // استقبال البيانات الخام من جسم الطلب وتحويلها من JSON
    $data = json_decode(file_get_contents("php://input"));

    // التحقق من وجود البيانات المطلوبة
    if (empty($data->email) || empty($data->password)) {
        http_response_code(400 ); // Bad Request
        echo json_encode(["success" => false, "message" => "Email and password are required."]);
        exit();
    }

    $email = $data->email;
    $password = $data->password;

    // البحث عن المستخدم في قاعدة البيانات
    $sql = "SELECT * FROM users WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // التحقق من تطابق كلمة المرور المشفرة
        if (password_verify($password, $user['password'])) {
            // نجاح تسجيل الدخول
            unset($user['password']); // إزالة كلمة المرور من الاستجابة
            echo json_encode(["success" => true, "message" => "Login successful.", "user" => $user]);
        } else {
            // كلمة المرور غير صحيحة
            http_response_code(401 ); // Unauthorized
            echo json_encode(["success" => false, "message" => "Invalid email or password."]);
        }
    } else {
        // المستخدم غير موجود
        http_response_code(401 ); // Unauthorized
        echo json_encode(["success" => false, "message" => "Invalid email or password."]);
    }

    $stmt->close();
    $conn->close();

} catch (Exception $e) {
    // التعامل مع أي أخطاء غير متوقعة
    http_response_code(500 ); // Internal Server Error
    echo json_encode(["success" => false, "message" => "An error occurred: " . $e->getMessage()]);
}
?>
