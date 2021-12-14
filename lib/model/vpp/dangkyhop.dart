import 'package:egovapp/model/danhmuc/phong.dart';
class DangKyHop
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
  final Phong phong;
  final String pheDuyet;
  DangKyHop({
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
    required this.phong,
    required this.pheDuyet

  });
  factory DangKyHop.fromJson(Map<String, dynamic>? json) {
    return DangKyHop(
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
        phong: Phong.fromJson(json!= null ?json['phong']: null),
        pheDuyet: json!= null &&  json['pheDuyet'] != null? json['pheDuyet']: ''
    );
  }
}