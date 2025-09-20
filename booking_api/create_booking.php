<?php
// إعدادات الاستجابة لضمان أن تكون دائماً بصيغة JSON
header('Content-Type: application/json; charset=utf-8');

// 1. الاتصال بقاعدة البيانات
$conn = include __DIR__ . '/db_connect.php';
if ($conn->connect_error) {
    // في حال فشل الاتصال، أرسل رسالة خطأ واضحة وأوقف التنفيذ
    echo json_encode(["success" => false, "message" => "PHP Error: Connection failed: " . $conn->connect_error]);
    exit();
}
// ضمان أن البيانات ستتعامل مع اللغة العربية بشكل صحيح
$conn->set_charset("utf8");

// 2. التحقق من أن كل الحقول المطلوبة قد تم إرسالها من فلاتر
$required_fields = ['user_id', 'provider_id', 'service_id', 'total_amount', 'service_type', 'passengers', 'details'];
foreach ($required_fields as $field) {
    if (!isset($_POST[$field])) {
        echo json_encode(["success" => false, "message" => "PHP Error: Missing required field from Flutter: " . $field]);
        exit();
    }
}

// 3. بدء معاملة (Transaction) لضمان أن كل عمليات الحفظ تتم معاً أو لا تتم على الإطلاق
$conn->begin_transaction();

try {
    // 4. إدراج البيانات في جدول الحجوزات الرئيسي (bookings)
    $stmt_booking = $conn->prepare("INSERT INTO bookings (user_id, provider_id, service_id, total_amount, status) VALUES (?, ?, ?, ?, 'Confirmed')");
    if ($stmt_booking === false) throw new Exception("Prepare failed (bookings): " . $conn->error);
    $stmt_booking->bind_param("iiid", $_POST['user_id'], $_POST['provider_id'], $_POST['service_id'], $_POST['total_amount']);
    $stmt_booking->execute();
    $booking_id = $conn->insert_id; // الحصول على ID الحجز الجديد لاستخدامه في الجداول الأخرى
    $stmt_booking->close();

    // 5. معالجة بيانات المسافرين والصور
    $passengers = json_decode($_POST['passengers'], true); // تحويل نص المسافرين من JSON إلى مصفوفة
    if (json_last_error() !== JSON_ERROR_NONE) throw new Exception("Invalid JSON in 'passengers' data.");

    // التأكد من وجود مجلد الرفع، وإنشائه إذا لم يكن موجوداً
    $upload_dir = 'uploads/passports/';
    if (!is_dir($upload_dir)) mkdir($upload_dir, 0777, true);

    $stmt_traveler = $conn->prepare("INSERT INTO travelers (booking_id, full_name, passport_number, passport_image_url) VALUES (?, ?, ?, ?)");
    if ($stmt_traveler === false) throw new Exception("Prepare failed (travelers): " . $conn->error);

    // المرور على كل مسافر وحفظ بياناته وصورته
    foreach ($passengers as $index => $passenger) {
        $image_path = null;
        $photo_key = 'passenger_photo_' . $index;
        if (isset($_FILES[$photo_key]) && $_FILES[$photo_key]['error'] == 0) {
            $file_name = uniqid() . '-' . basename($_FILES[$photo_key]['name']);
            $target_file = $upload_dir . $file_name;
            if (move_uploaded_file($_FILES[$photo_key]['tmp_name'], $target_file)) {
                $image_path = $target_file;
            }
        }
        $stmt_traveler->bind_param("isss", $booking_id, $passenger['name'], $passenger['passport'], $image_path);
        $stmt_traveler->execute();
    }
    $stmt_traveler->close();

    // 6. معالجة التفاصيل بناءً على نوع الخدمة
    $service_type = $_POST['service_type'];
    $details = json_decode($_POST['details'], true); // فتح "صندوق" التفاصيل
    if (json_last_error() !== JSON_ERROR_NONE) throw new Exception("Invalid JSON in 'details' data.");
    if (!is_array($details)) throw new Exception("'details' did not decode to an array.");

    // التحقق من نوع الخدمة وتوجيه البيانات إلى الجدول الصحيح
    if ($service_type == 'حجز طيران') {
        $from = $details['from'] ?? null;
        $to = $details['to'] ?? null;
        $seat_class = $details['seat_class'] ?? null;
        if ($from === null || $to === null || $seat_class === null) throw new Exception("Missing required flight details.");

        $stmt_details = $conn->prepare("INSERT INTO flightbookingdetails (booking_id, departure_airport, arrival_airport, departure_datetime, seat_class) VALUES (?, ?, ?, ?, ?)");
        if ($stmt_details === false) throw new Exception("Prepare failed (flightbookingdetails): " . $conn->error);
        
        $departure_datetime = trim(($details['travel_date'] ?? '') . ' ' . ($details['travel_time'] ?? ''));
        $stmt_details->bind_param("issss", $booking_id, $from, $to, $departure_datetime, $seat_class);
        $stmt_details->execute();
        $stmt_details->close();

    } elseif ($service_type == 'نقل بري') {
        $from = $details['from'] ?? null;
        $to = $details['to'] ?? null;
        $vehicle_type = $details['vehicle_type'] ?? null;
        if ($from === null || $to === null || $vehicle_type === null) throw new Exception("Missing required land transport details.");

        $stmt_details = $conn->prepare("INSERT INTO landtransportdetails (booking_id, pickup_location, dropoff_location, travel_datetime, vehicle_type) VALUES (?, ?, ?, ?, ?)");
        if ($stmt_details === false) throw new Exception("Prepare failed (landtransportdetails): " . $conn->error);

        $travel_datetime = trim(($details['travel_date'] ?? '') . ' ' . ($details['travel_time'] ?? ''));
        $stmt_details->bind_param("issss", $booking_id, $from, $to, $travel_datetime, $vehicle_type);
        $stmt_details->execute();
        $stmt_details->close();

    } elseif ($service_type == 'حجز فنادق') {
        $check_in = $details['check_in'] ?? null;
        $check_out = $details['check_out'] ?? null;
        $room_type = $details['room_type'] ?? 'غرفة عادية'; // قيمة افتراضية إذا لم يتم إرسالها
        if ($check_in === null || $check_out === null) throw new Exception("Missing required hotel details (check-in or check-out).");

        $stmt_details = $conn->prepare("INSERT INTO hotelbookingdetails (booking_id, check_in_date, check_out_date, number_of_guests, number_of_rooms, room_type) VALUES (?, ?, ?, ?, ?, ?)");
        if ($stmt_details === false) throw new Exception("Prepare failed (hotelbookingdetails): " . $conn->error);
        
        $room_type = 'Standard'; // قيمة افتراضية
        $guests = intval($details['guests'] ?? 1);
        $rooms = intval($details['rooms'] ?? 1);
        $stmt_details->bind_param("issiis", $booking_id, $check_in, $check_out, $guests, $rooms, $room_type);
        $stmt_details->execute();
        $stmt_details->close();
    }

    // 7. إذا نجحت كل العمليات السابقة، قم بتأكيد كل التغييرات في قاعدة البيانات
    $conn->commit();
    echo json_encode(["success" => true, "message" => "Booking created successfully!", "booking_id" => $booking_id]);

} catch (Exception $e) {
    // 8. إذا حدث أي خطأ في أي خطوة، قم بالتراجع عن كل التغييرات وأرسل رسالة خطأ واضحة
    $conn->rollback();
    echo json_encode(["success" => false, "message" => "PHP Error: " . $e->getMessage()]);
}

// 9. إغلاق الاتصال بقاعدة البيانات في كل الحالات
$conn->close();
?>
