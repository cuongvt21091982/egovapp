import 'package:egovapp/model/staffs/staff.dart';

class DangKyNguoiDuyet
{
  final int id;
  final int dangKyId;
  final int staffId;
  final String noiDung;
  final int status;
  final int typeDK;
  final String ngayTao;
  final String ngayDuyet;
  final Staff nguoiDuyet;
  DangKyNguoiDuyet({
    required this.id,
    required this.dangKyId,
    required this.staffId,
    required this.noiDung,
    required this.status,
    required this.typeDK,
    required this.ngayTao,
    required this.ngayDuyet,
    required this.nguoiDuyet

  });
  factory DangKyNguoiDuyet.fromJson(Map<String, dynamic>? json) {
    return DangKyNguoiDuyet(
        id: json!= null && json['id'] != null? json['id']: 0,
        dangKyId: json!= null && json['dangKyId'] != null? json['dangKyId']: 0,
        staffId: json!= null &&  json['staffId'] != null? json['staffId']: 0,
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        status: json!= null &&  json['status'] != null? json['status']: 0,
        typeDK: json!= null &&  json['typeDK'] != null? json['typeDK']: 0,
        ngayTao: json!= null &&  json['ngayTao'] != null? json['ngayTao']: '',
        ngayDuyet: json!= null &&  json['ngayDuyet'] != null? json['ngayDuyet']: '',
        nguoiDuyet:  Staff.fromJson(json!= null ?json['nguoiDuyet']: null),
    );
  }
}