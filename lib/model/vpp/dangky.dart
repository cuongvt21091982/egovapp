import 'package:egovapp/model/danhmuc/thietbi.dart';
class DangKy
{
  final int dangKyId;
  final String ngay;
  final String thoiGian;
  final String noiDung;
  final String nguoiChuTri;
  final int phongID;
  final String ghiChu;
  final int nguoiDangKyID;
  final String yeuCauTraLoi;
  final int trangThai;
  final String thoiGianDangKy;
  final String logDangKy;
  final ThietBi thietBi;
  final String pheDuyet;
  DangKy({
    required this.dangKyId,
    required this.ngay,
    required this.thoiGian,
    required this.noiDung,
    required this.nguoiChuTri,
    required this.phongID,
    required this.ghiChu,
    required this.nguoiDangKyID,
    required this.yeuCauTraLoi,
    required this.trangThai,
    required this.thoiGianDangKy,
    required this.logDangKy,
    required this.thietBi,
    required this.pheDuyet

  });
  factory DangKy.fromJson(Map<String, dynamic>? json) {
    return DangKy(
        dangKyId: json!= null && json['dangKyId'] != null? json['dangKyId']: 0,
        ngay: json!= null &&  json['ngay'] != null? json['ngay']: '',
        thoiGian: json!= null &&  json['thoiGian'] != null? json['thoiGian']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        nguoiChuTri: json!= null &&  json['nguoiChuTri'] != null? json['nguoiChuTri']: '',
        phongID: json!= null &&  json['phongID'] != null? json['phongID']: 0,
        ghiChu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
        nguoiDangKyID: json!= null &&  json['nguoiDangKyID'] != null? json['nguoiDangKyID']: 0,
        yeuCauTraLoi: json!= null &&  json['yeuCauTraLoi'] != null? json['yeuCauTraLoi']: '',
        trangThai: json!= null &&  json['trangThai'] != null? json['trangThai']: 0,
        thoiGianDangKy: json!= null &&  json['thoiGianDangKy'] != null? json['thoiGianDangKy']: '',
        logDangKy: json!= null &&  json['logDangKy'] != null? json['logDangKy']: '',
        thietBi: ThietBi.fromJson(json!= null ?json['thietBi']: null),
        pheDuyet: json!= null &&  json['pheDuyet'] != null? json['pheDuyet']: ''
    );
  }
}