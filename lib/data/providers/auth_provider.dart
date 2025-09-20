import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider {
  // هام: استخدم هذا العنوان إذا كنت تختبر على محاكي أندرويد
  final String _baseUrl = "http://192.168.0.114/booking_api";

  // إذا كنت تختبر على هاتف حقيقي، استبدل العنوان بعنوان IP لجهاز الكمبيوتر
  // يمكنك الحصول عليه بكتابة 'ipconfig' في موجه الأوامر (cmd ) في ويندوز
  // مثال: final String _baseUrl = "http://192.168.0.119/booking_api";

  // --- دالة تسجيل الدخول ---
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/login.php');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Server Error on Login: ${response.statusCode}");
        print("Response: ${response.body}");
        return {'success': false, 'message': 'Server error occurred.'};
      }
    } catch (e) {
      print("Network Error on Login: $e");
      return {'success': false, 'message': 'Network connection failed.'};
    }
  }

  // --- دالة تسجيل مستخدم جديد ---
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    final url = Uri.parse('$_baseUrl/register.php');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'full_name': fullName, // تأكد من استخدام 'full_name' كما في كود PHP
          'email': email,
          'password': password,
          'phone_number': phoneNumber, // استخدام 'phone_number'
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Server Error on Register: ${response.statusCode}");
        print("Response: ${response.body}");
        return {'success': false, 'message': 'Server error occurred.'};
      }
    } catch (e) {
      print("Network Error on Register: $e");
      return {'success': false, 'message': 'Network connection failed.'};
    }
  }
}
