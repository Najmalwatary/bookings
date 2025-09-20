<?php
// -----------------------------------------------------------------------------
// 1. إعدادات CORS (Cross-Origin Resource Sharing)
// -----------------------------------------------------------------------------
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// -----------------------------------------------------------------------------
// 2. التعامل مع طلبات OPTIONS الأولية (Preflight Requests)
// -----------------------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(204 );
    exit();
}

// -----------------------------------------------------------------------------
// 3. التحقق من أن الطلب الفعلي هو POST
// -----------------------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    http_response_code(405 );
    echo json_encode(["success" => false, "message" => "Invalid request method. Only POST is accepted."]);
    exit();
}

// -----------------------------------------------------------------------------
// 4. تضمين ملف الاتصال بقاعدة البيانات
// -----------------------------------------------------------------------------
$conn = include __DIR__ . '/db_connect.php';

if (!$conn) {
    http_response_code(500 );
    echo json_encode(["success" => false, "message" => "Database connection failed."]);
    exit();
}

// -----------------------------------------------------------------------------
// 5. منطق تسجيل مستخدم جديد
// -----------------------------------------------------------------------------
try {
    $data = json_decode(file_get_contents("php://input"));

    // التحقق من وجود البيانات المطلوبة
    if (empty($data->full_name) || empty($data->email) || empty($data->password)) {
        http_response_code(400 );
        echo json_encode(["success" => false, "message" => "Full name, email, and password are required."]);
        exit();
    }

    $fullName = $data->full_name;
    $email = $data->email;
    $password = $data->password;
    // رقم الهاتف اختياري
    $phoneNumber = $data->phone_number ?? null;

    // التحقق مما إذا كان البريد الإلكتروني مسجلاً بالفعل
    $sql = "SELECT user_id FROM users WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        http_response_code(409 ); // Conflict
        echo json_encode(["success" => false, "message" => "This email is already registered."]);
        $stmt->close();
        $conn->close();
        exit();
    }
    $stmt->close();

    // تشفير كلمة المرور
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // إدخال المستخدم الجديد في قاعدة البيانات
    $sql = "INSERT INTO users (full_name, email, password, phone_number) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssss", $fullName, $email, $hashedPassword, $phoneNumber);

    if ($stmt->execute()) {
        http_response_code(201 ); // Created
        echo json_encode(["success" => true, "message" => "User registered successfully."]);
    } else {
        http_response_code(500 );
        echo json_encode(["success" => false, "message" => "Failed to register user."]);
    }

    $stmt->close();
    $conn->close();

} catch (Exception $e) {
    http_response_code(500 );
    echo json_encode(["success" => false, "message" => "An error occurred: " . $e->getMessage()]);
}
?>
