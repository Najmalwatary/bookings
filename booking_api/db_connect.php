<?php
// معلومات الاتصال بقاعدة البيانات
$servername = "localhost:3306";
$username = "root";
$password = "";
$dbname = "booking_app_db";

// إنشاء الاتصال
$conn = new mysqli($servername, $username, $password, $dbname);

// التحقق من نجاح الاتصال
if ($conn->connect_error) {
    // لا تعرض الخطأ مباشرة، بل أوقِف التنفيذ برسالة عامة
    // هذا أفضل من ناحية الأمان
    http_response_code(500 );
    echo json_encode(["success" => false, "message" => "Database connection failed."]);
    exit();
}

// ضبط الترميز
$conn->set_charset("utf8mb4");

// إرجاع كائن الاتصال ليكون متاحاً للملف الذي يقوم بتضمينه
return $conn;
?>
