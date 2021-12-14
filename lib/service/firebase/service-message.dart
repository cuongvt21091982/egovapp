import 'dart:convert';

import 'package:http/http.dart' as http;
class ServiceMessage
{
  Future<void> sendPushMessage(String _token,String title, String message) async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "key=AAAAY6Qof_Y:APA91bFgY3Pb5xsU3QR1XoyYYgFuYn7HxvkApSPY_aE9hus9VSTVA7cTkJwEhkbyQxJ72e9ehHv7TZLmHZ85cJ8Yzy0G-2WtDnsk7_SUTNQP_InVpLorP468oqPk7DtxDPQ4QtSCRdcK"
        },
        body: jsonEncode({
          'to': _token,
          'notification': {
            'title': '${title}',
            'body': '${message}',
          },
        }),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

}