import 'package:egovapp/model/staffs/staff.dart';
class KeHoachNguoiDoc
{
  final int id;
  final int keHoachID;
  final int staffID;
  final Staff nguoiDoc;

  KeHoachNguoiDoc({
    required this.id,
    required this.keHoachID,
    required this.staffID,
    required this.nguoiDoc
  });
  factory KeHoachNguoiDoc.fromJson(Map<String, dynamic>? json) {
    return KeHoachNguoiDoc(
        id: json!= null && json['id'] != null? json['id']: 0,
        keHoachID: json!= null &&  json['keHoachID'] != null? json['keHoachID']: 0,
        staffID: json!= null &&  json['staffID'] != null? json['staffID']: 0,
        nguoiDoc: Staff.fromJson(json!= null ?json['nguoiDoc']: null)
    );
  }
}