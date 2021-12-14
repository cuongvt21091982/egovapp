import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/yeucau/yeucaufilenxl.dart';
class YeuCauComment
{
  final int  id;
  final int  maXLId;
  final String  comment;
  final int  staffId;
  final String  created;
  final Staff  staffs;
  final int status;
  final int soLanDoc;
  final String thoiGianXem;
  List<YeuCauFileNXL> yeuCauFileNXLs;
  YeuCauComment({
    required this.id,
    required this.maXLId,
    required this.comment,
    required this.staffId,
    required this.created,
    required this.staffs,
    required this.status,
    required this.soLanDoc,
    required this.thoiGianXem,
    required this.yeuCauFileNXLs
  });
  factory YeuCauComment.fromJson(Map<String, dynamic>? json) {
    return YeuCauComment(
        id: json!=null && json['id'] != null ? json['id'] : 0,
        maXLId:  json!=null && json['maXLId'] != null ? json['maXLId'] : 0,
        comment: json!=null && json['comment'] != null ? json['comment'] : '',
        staffId: json!=null && json['staffId'] != null ? json['staffId'] : 0,
        created: json!=null && json['created'] != null ? json['created'] : '',
        staffs: Staff.fromJson(json!=null && json['staffs'] != null ? json['staffs']: null),
        status: json!=null && json['status'] != null ? json['status'] : 0,
        soLanDoc: json!=null && json['soLanDoc'] != null ? json['soLanDoc'] : 0,
        thoiGianXem: json!=null && json['thoiGianXem'] != null ? json['thoiGianXem'] : '',
        yeuCauFileNXLs: json!=null && json['yeuCauFileNXLs'] != null
            ? (json['yeuCauFileNXLs'] as List)
            .map((data) => YeuCauFileNXL.fromJson(data))
            .toList()
            : []
    );
  }
}