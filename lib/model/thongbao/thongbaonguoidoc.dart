import 'package:egovapp/model/staffs/staff.dart';
class ThongBaoNguoiDoc
{
  final int id;
  final int thongBaoID;
  final int staffID;
  final Staff nguoiDoc;

  ThongBaoNguoiDoc({
    required this.id,
    required this.thongBaoID,
    required this.staffID,
    required this.nguoiDoc
  });
  factory ThongBaoNguoiDoc.fromJson(Map<String, dynamic>? json) {
    return ThongBaoNguoiDoc(
        id: json!= null && json['id'] != null? json['id']: 0,
        thongBaoID: json!= null &&  json['thongBaoID'] != null? json['thongBaoID']: 0,
        staffID: json!= null &&  json['staffID'] != null? json['staffID']: 0,
        nguoiDoc: Staff.fromJson(json!= null ?json['nguoiDoc']: null)
    );
  }
}