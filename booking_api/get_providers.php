<?php
// --- get_providers.php (النسخة النهائية) ---

$conn = include __DIR__ . '/db_connect.php';

// ضبط الترميز لدعم اللغة العربية بشكل صحيح
mysqli_set_charset($conn, "utf8");

// --- 3. التحقق من نجاح الاتصال ---
if ($conn->connect_error) {
    // في حالة فشل الاتصال، أرسل رسالة خطأ بصيغة JSON وتوقف
    $response = ["success" => false, "message" => "فشل الاتصال بقاعدة البيانات: " . $conn->connect_error];
    echo json_encode($response);
    die(); // إيقاف تنفيذ الكود
}

// --- 4. كتابة استعلام SQL لجلب كل البيانات المطلوبة ---
// تأكد من أن أسماء الأعمدة (provider_name, provider_image, إلخ) مطابقة تماماً لما في جدولك
$sql = "SELECT 
            p.provider_id, 
            p.provider_name, 
            p.provider_image,
            p.provider_phone,
            p.location,
            p.rating,
            s.service_name
        FROM 
            providers p
        JOIN 
            services s ON p.service_id = s.service_id
        WHERE 
            p.is_active = 1";

$result = $conn->query($sql);

// --- 5. معالجة النتائج ---
$data = array(); // إنشاء مصفوفة فارغة لتخزين البيانات
// التحقق من وجود نتائج
if ($result && $result->num_rows > 0) {
    // جلب البيانات من كل صف وإضافتها إلى مصفوفة البيانات
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

// --- 6. إغلاق الاتصال ---
$conn->close();

// --- 7. إرسال الرد النهائي بصيغة JSON ---
// الرد يحتوي على مفتاح "success" ومفتاح "data" الذي يحمل مصفوفة المكاتب
$response = ["success" => true, "data" => $data];
echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT); // خيارات لطباعة JSON بشكل أنيق وداعم للعربية

?>
