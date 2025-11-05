import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymenFuncs {
  
}
/// Sends a confirmation email after successful event payment.
///
/// [userEmail] - the email address of the customer.
/// [userName]  - the name of the customer.

Future<bool> sendEventPaymentConfirmation({
  required String userEmail,
  required String userName,

}) async {
  const serviceId = 'service_ik49xcd';
  const templateId = 'template_pc9jj7q';
  const publicKey = 'P7s_-tip5ZWbKzk8n';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  try {
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost', 
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'to_email': userEmail,
          'user_name': userName,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Email sent successfully');
      return true;
    } else {
      print('❌ Failed to send email: ${response.body}');
      return false;
    }
  } catch (e) {
    print('⚠️ Error sending email: $e');
    return false;
  }
}
