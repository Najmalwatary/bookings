<?php
$conn = include __DIR__ . '/db_connect.php';

// التحقق من الاتصال
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Connection failed: " . $conn->connect_error]));
}

// 2. استقبال bank_id من الطلب
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['bank_id'])) {
    
    $bank_id = $_POST['bank_id'];

    // 3. تحضير الاستعلام بالاسم الصحيح للجدول 'provideraccounts'
    $stmt = $conn->prepare("SELECT account_number FROM provideraccounts WHERE bank_id = ? LIMIT 1");
    $stmt->bind_param("i", $bank_id);
    
    // تنفيذ الاستعلام
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // 4. جلب البيانات وإرجاعها كـ JSON
        $row = $result->fetch_assoc();
        echo json_encode(["success" => true, "account_number" => $row['account_number']]);
    } else {
        echo json_encode(["success" => false, "message" => "No account found for this bank."]);
    }

    $stmt->close();

} else {
    // إذا لم يتم إرسال bank_id
    echo json_encode(["success" => false, "message" => "Invalid request. Please provide a bank_id."]);
}

$conn->close();
?>
