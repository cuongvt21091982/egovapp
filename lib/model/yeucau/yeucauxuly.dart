import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/yeucau/yeucaufile.dart';

class YeuCauXuLy
{
  final int id;
  final String chuDe;
  final String noiDung;
  final String traLoi;
  final String thoiGianGui;
  final String ngayGui;
  final String thoiGianHoanThanh;
  final int maNguoiXuLy;
  final Staff nguoiXuLy;
  final int maNguoiChuTri;
  final Staff nguoiChuTri;
  final int trangThai;
  final int xem;
  final int xepLoai;
  final String ghichu;
  final int maNguoiDG;
  final String usersWrite;
  final int soLanDoc;
  final String thoiGianXemLanDau;
  final String thoiGianXemLanCuoi;
  final DateTime? receivedDate;
  List<YeuCauFile> yeuCauFiles;
  YeuCauXuLy({
    required this.id,
    required this.chuDe,
    required this.noiDung,
    required this.traLoi,
    required this.thoiGianGui,
    required this.ngayGui,
    required this.thoiGianHoanThanh,
    required this.maNguoiXuLy,
    required this.nguoiXuLy,
    required this.maNguoiChuTri,
    required this.nguoiChuTri,
    required this.trangThai,
    required this.xem,
    required this.xepLoai,
    required this.ghichu,
    required this.maNguoiDG,
    required this.usersWrite,
    required this.soLanDoc,
    required this.thoiGianXemLanDau,
    required this.thoiGianXemLanCuoi,
    required this.receivedDate,
    required this.yeuCauFiles

  });
  factory YeuCauXuLy.fromJson(Map<String, dynamic>? json) {
    return YeuCauXuLy(
        id: json!= null && json['id'] != null? json['id']: 0,
        chuDe: json!= null &&  json['chuDe'] != null? json['chuDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        traLoi: json!= null &&  json['traLoi'] != null? json['traLoi']: '',
        thoiGianGui: json!= null &&  json['thoiGianGui'] != null? json['thoiGianGui']: '',
        ngayGui: json!= null &&  json['thoiGianGui'] != null? json['thoiGianGui']: '',
        thoiGianHoanThanh: json!= null &&  json['thoiGianHoanThanh'] != null? json['thoiGianHoanThanh']: '',
        maNguoiXuLy: json!= null &&  json['maNguoiXuLy'] != null? json['maNguoiXuLy']: 0,
        nguoiXuLy:  Staff.fromJson(json!= null ?json['nguoiXuLy']: null),
        maNguoiChuTri: json!= null &&  json['maNguoiChuTri'] != null? json['maNguoiChuTri']: 0,
        nguoiChuTri:  Staff.fromJson(json!= null ?json['nguoiChuTri']: null),
        trangThai: json!= null &&  json['trangThai'] != null? json['trangThai']: 0,
        xem: json!= null &&  json['xem'] != null? json['xem']: 0,
        xepLoai: json!= null &&  json['xepLoai'] != null? json['xepLoai']: 0,
        ghichu: json!= null &&  json['ghichu'] != null? json['ghichu']: '',
        maNguoiDG: json!= null &&  json['maNguoiDG'] != null? json['maNguoiDG']: 0,
        usersWrite: json!= null &&  json['usersWrite'] != null? json['usersWrite']: '',
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXemLanDau: json!= null &&  json['thoiGianXemLanDau'] != null? json['thoiGianXemLanDau']: '',
        thoiGianXemLanCuoi: json!= null &&  json['thoiGianXemLanCuoi'] != null? json['thoiGianXemLanCuoi']: '',
        receivedDate: json!= null && json['receivedDate'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['receivedDate'].toString()): null,
        yeuCauFiles: json!= null &&  json['yeuCauFiles']!=null? (json['yeuCauFiles'] as List)
            .map((data) => YeuCauFile.fromJson(data))
            .toList(): []
    );
  }
}
