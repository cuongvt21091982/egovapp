import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/totrinh/totrinhfile.dart';
import 'package:egovapp/model/yeucau/yeucaufile.dart';

class YeuCau
{
  final int id;
  final String chuDe;
  final String noiDung;
  final String thoiGianGui;
  final String ngayGui;
  final String ketQua;
  final String thoiGianHoanThanh;
  final int maNguoiChuTri;
  final int trangThai;
  final int xem;
  final int xepLoai;
  final String ghichu;
  final int maNguoiDG;
  final int choThamKhao;
  final String usersWrite;
  final int soLuotDoc;
  final int soLanDoc;
  final String thoiGianXemLanDau;
  final String thoiGianXemLanCuoi;
  final Staff nguoiChuTri;
  final DateTime? created;
  final DateTime? sendDate;
  List<YeuCauFile> yeuCauFiles;
  YeuCau({
    required this.id,
    required this.chuDe,
    required this.noiDung,
    required this.thoiGianGui,
    required this.ngayGui,
    required this.ketQua,
    required this.thoiGianHoanThanh,
    required this.maNguoiChuTri,
    required this.trangThai,
    required this.xem,
    required this.xepLoai,
    required this.ghichu,
    required this.maNguoiDG,
    required this.choThamKhao,
    required this.usersWrite,
    required this.soLuotDoc,
    required this.soLanDoc,
    required this.thoiGianXemLanDau,
    required this.thoiGianXemLanCuoi,
    required this.nguoiChuTri,
    required this.created,
    required this.sendDate,
    required this.yeuCauFiles

  });
  factory YeuCau.fromJson(Map<String, dynamic>? json) {
    return YeuCau(
        id: json!= null && json['id'] != null? json['id']: 0,
        chuDe: json!= null &&  json['chuDe'] != null? json['chuDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        thoiGianGui: json!= null &&  json['thoiGianGui'] != null? json['thoiGianGui']: '',
        ngayGui: json!= null &&  json['thoiGianGui'] != null? json['thoiGianGui']: '',
        ketQua: json!= null &&  json['ketQua'] != null? json['ketQua']: '',
        thoiGianHoanThanh: json!= null &&  json['thoiGianHoanThanh'] != null? json['thoiGianHoanThanh']: '',
        maNguoiChuTri: json!= null &&  json['maNguoiChuTri'] != null? json['maNguoiChuTri']: 0,
        trangThai: json!= null &&  json['trangThai'] != null? json['trangThai']: 0,
        xem: json!= null &&  json['xem'] != null? json['xem']: 0,
        xepLoai: json!= null &&  json['xepLoai'] != null? json['xepLoai']: 0,
        ghichu: json!= null &&  json['ghichu'] != null? json['ghichu']: '',
        maNguoiDG: json!= null &&  json['maNguoiDG'] != null? json['maNguoiDG']: 0,
        choThamKhao: json!= null &&  json['choThamKhao'] != null? json['choThamKhao']: 0,
        usersWrite: json!= null &&  json['usersWrite'] != null? json['usersWrite']: '',
        soLuotDoc: json!= null &&  json['soLuotDoc'] != null? json['soLuotDoc']: 0,
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXemLanDau: json!= null &&  json['thoiGianXemLanDau'] != null? json['thoiGianXemLanDau']: '',
        thoiGianXemLanCuoi: json!= null &&  json['thoiGianXemLanCuoi'] != null? json['thoiGianXemLanCuoi']: '',
        nguoiChuTri:  Staff.fromJson(json!= null ?json['nguoiChuTri']: null),
        created: json!= null && json['created'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['created'].toString()): null,
        sendDate: json!= null && json['sendDate'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['sendDate'].toString()): null,
        yeuCauFiles: json!= null &&  json['yeuCauFiles']!=null? (json['yeuCauFiles'] as List)
            .map((data) => YeuCauFile.fromJson(data))
            .toList(): []
    );
  }
}
