import 'package:egovapp/constants/format-util.dart';

class NotificationItem
{
  final int  id;
  final String  messageId;
  final int codeId;
  final String  notificationType;
  final String title;
  final String  body;
  final int staffId;
  final String token;
  final int status;
  final DateTime? created;
  final DateTime? sended;
  NotificationItem(
      {
        required this.id,
        required this.messageId,
        required this.codeId,
        required this.notificationType,
        required this.title,
        required this.body,
        required this.staffId,
        required this.token,
        required this.status,
        required this.created,
        required this.sended,
      });
  factory NotificationItem.fromJson(Map<String, dynamic>? json) {
    return NotificationItem(
      id: json!= null && json['id'] != null? json['id']: 0,
      messageId: json!= null && json['messageId'] != null? json['messageId']: '',
      codeId: json!= null && json['codeId'] != null? json['codeId']: 0,
      notificationType: json!= null && json['notificationType'] != null? json['notificationType']: '',
      title: json!= null && json['title'] != null? json['title']: '',
      body: json!= null && json['body'] != null? json['body']: '',
      staffId: json!= null && json['staffId'] != null? json['staffId']: 0,
      token: json!= null && json['token'] != null? json['token']: '',
      status: json!= null && json['status'] != null? json['status']: 0,
      created: json!= null && json['created'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['created'].toString()): null,
      sended: json!= null && json['sended'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['sended'].toString()): null
    );
  }
}