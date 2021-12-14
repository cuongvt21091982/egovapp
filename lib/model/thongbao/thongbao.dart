import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/thongbao/thongbaofile.dart';

class ThongBao
{
  final int id;
  final String chuDe;
  final String noiDung;
  final String ngayNhap;
  final String ngayHieuLuc;
  final String gioHieuLuc;
  final String ngayHetHieuLuc;
  final int nguoiNhap;
  final int soLuotDoc;
  final int phoCap;
  final Staff nguoiNhapItem;
  List<ThongBaoFile> thongBaoFiles;
  ThongBao({
    required this.id,
    required this.chuDe,
    required this.noiDung,
    required this.ngayNhap,
    required this.ngayHieuLuc,
    required this.gioHieuLuc,
    required this.ngayHetHieuLuc,
    required this.nguoiNhap,
    required this.soLuotDoc,
    required this.phoCap,
    required this.nguoiNhapItem,
    required this.thongBaoFiles

  });
  factory ThongBao.fromJson(Map<String, dynamic>? json) {
    return ThongBao(
        id: json!= null && json['id'] != null? json['id']: 0,
        chuDe: json!= null &&  json['chuDe'] != null? json['chuDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        ngayNhap: json!= null &&  json['ngayNhap'] != null? json['ngayNhap']: '',
        ngayHieuLuc: json!= null &&  json['ngayHieuLuc'] != null? json['ngayHieuLuc']: '',
        gioHieuLuc: json!= null &&  json['gioHieuLuc'] != null? json['gioHieuLuc']: '',
        ngayHetHieuLuc: json!= null &&  json['ngayHetHieuLuc'] != null? json['ngayHetHieuLuc']: '',
        nguoiNhap: json!= null &&  json['nguoiNhap'] != null? json['nguoiNhap']: 0,
        phoCap: json!= null &&  json['phoCap'] != null? json['phoCap']: 0,
        soLuotDoc: json!= null &&  json['soLuotDoc'] != null? json['soLuotDoc']: 0,
        nguoiNhapItem: Staff.fromJson(json!= null ?json['nguoiNhapItem']: null),
        thongBaoFiles: json!= null &&  json['thongBaoFiles']!=null? (json['thongBaoFiles'] as List)
            .map((data) => ThongBaoFile.fromJson(data))
            .toList(): []
    );
  }
}