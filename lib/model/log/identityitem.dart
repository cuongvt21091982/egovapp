import 'package:egovapp/model/danhmuc/loaikehoach.dart';
import 'package:egovapp/model/kehoach/kehoachfile.dart';
import 'package:egovapp/model/staffs/staff.dart';

class IdentityItem
{
  final int id;
  final String code;
  final String name;
  final int thuTu;
  final String type;
  final bool active;

  IdentityItem({
    required this.id,
    required this.code,
    required this.name,
    required this.thuTu,
    required this.type,
    required this.active
  });
  factory IdentityItem.fromJson(Map<String, dynamic>? json) {
    return IdentityItem(
        id: json!= null && json['id'] != null? json['id']: 0,
        code: json!= null &&  json['code'] != null? json['code']: '',
        name: json!= null &&  json['name'] != null? json['name']: '',
        thuTu: json!= null &&  json['thuTu'] != null? json['thuTu']: 0,
        type: json!= null &&  json['type'] != null? json['type']: '',
        active: json!= null &&  json['active'] != null? json['active']: false
    );
  }
}