import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/model/danhmuc/loaikehoach.dart';
import 'package:egovapp/model/kehoach/kehoachfile.dart';
import 'package:egovapp/model/log/identityitem.dart';
import 'package:egovapp/model/staffs/staff.dart';

class LogAction
{
  final int id;
  final String title;
  final String className;
  final String classPk;
  final String classFk;
  final String action;
  final int userId;
  final int staffId;
  final int userName;
  final DateTime? created;
  final Staff staffs;
  final IdentityItem identityItem;
  LogAction({
    required this.id,
    required this.title,
    required this.className,
    required this.classPk,
    required this.classFk,
    required this.action,
    required this.userId,
    required this.staffId,
    required this.userName,
    required this.created,
    required this.staffs,
    required this.identityItem,

  });
  factory LogAction.fromJson(Map<String, dynamic>? json) {
    return LogAction(
        id: json!= null && json['id'] != null? json['id']: 0,
        title: json!= null &&  json['title'] != null? json['title']: '',
        className: json!= null &&  json['className'] != null? json['className']: '',
        classPk: json!= null &&  json['classPk'] != null? json['classPk']: '',
        classFk: json!= null &&  json['classFk'] != null? json['classFk']: '',
        action: json!= null &&  json['action'] != null? json['action']: 0,
        userId: json!= null &&  json['userId'] != null? json['userId']: 0,
        staffId: json!= null &&  json['staffId'] != null? json['staffId']: 0,
        userName: json!= null &&  json['userName'] != null? json['userName']: '',
        created: json!= null && json['created'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['created'].toString()): null,
        staffs: Staff.fromJson(json!= null ?json['staffs']: null),
        identityItem: IdentityItem.fromJson(json!= null ?json['identityItem']: null),

    );
  }
}