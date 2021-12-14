import 'package:egovapp/model/meeting/meetingfile.dart';
import 'package:egovapp/model/staffs/staff.dart';

class MeetingXuLy
{
  final int id;
  final int maYeuCau;
  final String chuDe;
  final String noiDung;
  final String traLoi;
  final String thoiGianGui;
  final String ngayGui;
  final String thoiGianHoanThanh;
  final int maNguoiXuLy;
  final Staff nguoiXuLy;
  final int maNguoiChuTri;
  final int trangThai;
  final int xem;
  final int xepLoai;
  final String ghiChu;
  final int maNguoiDG;
  final String usersWrite;
  final int  soLanDoc;
  final String thoiGianXemLanDau;
  final String thoiGianXemLanCuoi;
  final List<MeetingFile> meetingFiles;
  final Staff  nguoiChuTri ;

  MeetingXuLy({
    required this.id,
    required this.maYeuCau,
    required this.chuDe,
    required this.noiDung,
    required this.traLoi,
    required this.thoiGianGui,
    required this.ngayGui,
    required this.thoiGianHoanThanh,
    required this.maNguoiXuLy,
    required this.nguoiXuLy,
    required this.maNguoiChuTri,
    required this.trangThai,
    required this.xem,
    required this.xepLoai,
    required this.ghiChu,
    required this.maNguoiDG,
    required this.usersWrite,
    required this.soLanDoc,
    required this.thoiGianXemLanDau,
    required this.thoiGianXemLanCuoi,
    required this.meetingFiles,
    required this.nguoiChuTri

  });
  factory MeetingXuLy.fromJson(Map<String, dynamic>? json) {
    return MeetingXuLy(
        id: json!= null && json['id'] != null? json['id']: 0,
        maYeuCau: json!= null && json['maYeuCau'] != null? json['maYeuCau']: 0,
        chuDe: json!= null &&  json['chuDe'] != null? json['chuDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        traLoi: json!= null &&  json['traLoi'] != null? json['traLoi']: '',
        thoiGianGui: json!= null &&  json['thoiGianGui'] != null? json['thoiGianGui']: '',
        ngayGui: json!= null &&  json['ngayGui'] != null? json['ngayGui']: '',
        thoiGianHoanThanh: json!= null &&  json['thoiGianHoanThanh'] != null? json['thoiGianHoanThanh']: '',
        maNguoiXuLy: json!= null &&  json['maNguoiXuLy'] != null? json['maNguoiXuLy']: 0,
        nguoiXuLy: Staff.fromJson(json!= null ?json['nguoiXuLy']: null),
        maNguoiChuTri: json!= null &&  json['maNguoiChuTri'] != null? json['maNguoiChuTri']: 0,
        trangThai: json!= null &&  json['trangThai'] != null? json['trangThai']: 0,
        xem: json!= null &&  json['xem'] != null? json['xem']: 0,
        xepLoai: json!= null &&  json['xepLoai'] != null? json['xepLoai']: 0,
        ghiChu: json!= null &&  json['ghichu'] != null? json['ghichu']: '',
        maNguoiDG: json!= null &&  json['maNguoiDG'] != null? json['maNguoiDG']: 0,
        usersWrite: json!= null &&  json['usersWrite'] != null? json['usersWrite']: '',
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXemLanDau: json!= null &&  json['thoiGianXemLanDau'] != null? json['thoiGianXemLanDau']: '',
        thoiGianXemLanCuoi: json!= null &&  json['thoiGianXemLanCuoi'] != null? json['thoiGianXemLanCuoi']: '',
        meetingFiles: json!= null &&  json['meetingFiles']!=null? (json['meetingFiles'] as List)
            .map((data) => MeetingFile.fromJson(data))
            .toList(): [],
        nguoiChuTri: Staff.fromJson(json!= null ?json['nguoiChuTri']: null)
    );
  }
}