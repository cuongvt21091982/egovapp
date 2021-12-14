import 'package:egovapp/model/staffs/staff.dart';
class VanBanDiXuLy
{
  final int id;
  final int maVB;
  final int maNguoiXuLy;
  final int maNguoiChuTri;
  final String ghiChu;
  final String ketQua;
  final int maTrangThaiXL;
  final String noidungYCXL;
  final int xeploaiDG;
  final int maNguoiDG;
  final int xem;
  final int tuHoanThanh;
  final String usersWrite;
  final int soLanDoc;
  final String thoiGianXemLanDau;
  final String thoiGianXemLanCuoi;
  final int capXuLy;
  final int maNguoiGiaoTiep;
  final String ndXuLyTiep;
  final int theoDoiCap2;
  final Staff nguoiXuLy;
  final Staff nguoiGiaoTiep;
  final Staff nguoiChuTri;
  VanBanDiXuLy({
    required this.id,
    required this.maVB,
    required this.maNguoiXuLy,
    required this.maNguoiChuTri,
    required this.ghiChu,
    required this.ketQua,
    required this.maTrangThaiXL,
    required this.noidungYCXL,
    required this.xeploaiDG,
    required this.maNguoiDG,
    required this.xem,
    required this.tuHoanThanh,
    required this.usersWrite,
    required this.soLanDoc,
    required this.thoiGianXemLanDau,
    required this.thoiGianXemLanCuoi,
    required this.capXuLy,
    required this.maNguoiGiaoTiep,
    required this.ndXuLyTiep,
    required this.theoDoiCap2,
    required this.nguoiXuLy,
    required this.nguoiGiaoTiep,
    required this.nguoiChuTri  });
  factory VanBanDiXuLy.fromJson(Map<String, dynamic>? json) {
    return VanBanDiXuLy(
      id: json!= null && json['id'] != null? json['id']: 0,
      maVB: json!= null &&  json['maVB'] != null? json['maVB']: 0,
      maNguoiXuLy: json!= null &&  json['maNguoiXuLy'] != null? json['maNguoiXuLy']: 0,
      maNguoiChuTri: json!= null &&  json['maNguoiChuTri'] != null? json['maNguoiChuTri']: 0,
      ghiChu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
      ketQua: json!= null &&  json['ketQua'] != null? json['ketQua']: '',
      maTrangThaiXL: json!= null &&  json['maTrangThaiXL'] != null? json['maTrangThaiXL']: 0,
      noidungYCXL: json!= null &&  json['noidungYCXL'] != null? json['noidungYCXL']: '',
      xeploaiDG: json!= null &&  json['xeploaiDG'] != null? json['xeploaiDG']: 0,
      maNguoiDG: json!= null &&  json['maNguoiDG'] != null? json['maNguoiDG']: 0,
      xem: json!= null &&  json['xem'] != null? json['xem']: 0,
      tuHoanThanh: json!= null &&  json['tuHoanThanh'] != null? json['tuHoanThanh']: 0,
      usersWrite: json!= null &&  json['usersWrite'] != null? json['usersWrite']: '',
      soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
      thoiGianXemLanDau: json!= null &&  json['thoiGianXemLanDau'] != null? json['thoiGianXemLanDau']: '',
      thoiGianXemLanCuoi: json!= null &&  json['thoiGianXemLanCuoi'] != null? json['thoiGianXemLanCuoi']: '',
      capXuLy: json!= null &&  json['capXuLy'] != null? json['capXuLy']: 0,
      maNguoiGiaoTiep: json!= null &&  json['maNguoiGiaoTiep'] != null? json['maNguoiGiaoTiep']: 0,
      ndXuLyTiep: json!= null &&  json['ndXuLyTiep'] != null? json['ndXuLyTiep']: '',
      theoDoiCap2: json!= null &&  json['theoDoiCap2'] != null? json['theoDoiCap2']: 0,
      nguoiXuLy: Staff.fromJson(json!= null ?json['nguoiXuLy']: null),
      nguoiGiaoTiep: Staff.fromJson(json!= null ?json['nguoiGiaoTiep']: null),
      nguoiChuTri: Staff.fromJson(json!= null ?json['nguoiChuTri']: null),

    );
  }
}