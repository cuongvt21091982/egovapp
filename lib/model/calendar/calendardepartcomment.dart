import 'package:egovapp/model/staffs/staff.dart';
class CalendarDepartComment
{
  final int  id;
  final int  maXLId;
  final int maNam;
  final String  comment;
  final int  staffId;
  final int donViId;
  final String  created;
  final Staff  staffs;
  final int status;
  final int soLanDoc;
  final String thoiGianXem;
  CalendarDepartComment({
    required this.id,
    required this.maXLId,
    required this.maNam,
    required this.comment,
    required this.staffId,
    required this.donViId,
    required this.created,
    required this.staffs,
    required this.status,
    required this.soLanDoc,
    required this.thoiGianXem
  });
  factory CalendarDepartComment.fromJson(Map<String, dynamic>? json) {
    return CalendarDepartComment(
        id: json!=null && json['id'] != null ? json['id'] : 0,
        maXLId:  json!=null && json['maXLId'] != null ? json['maXLId'] : 0,
        maNam:  json!=null && json['maNam'] != null ? json['maNam'] : 0,
        comment: json!=null && json['comment'] != null ? json['comment'] : '',
        staffId: json!=null && json['staffId'] != null ? json['staffId'] : 0,
        donViId: json!=null && json['donViId'] != null ? json['donViId'] : 0,
        created: json!=null && json['created'] != null ? json['created'] : '',
        staffs: Staff.fromJson(json!=null && json['staffs'] != null ? json['staffs']: null),
        status: json!=null && json['status'] != null ? json['status'] : 0,
        soLanDoc: json!=null && json['soLanDoc'] != null ? json['soLanDoc'] : 0,
        thoiGianXem: json!=null && json['thoiGianXem'] != null ? json['thoiGianXem'] : ''
    );
  }
}