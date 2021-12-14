import 'package:egovapp/model/hoso/hosofile.dart';
import 'package:egovapp/model/staffs/staff.dart';

class HoSo
{
  final int id;
  final String ngayTao;
  final String ngayKetThuc;
  final int beLongTo;
  final String tenHoSo;
  final int trangThai;
  final Staff nguoiTao;
  final String quaTrinhXuLy;
  List<HoSoFile> hoSoFiles;
  HoSo({
    required this.id,
    required this.ngayTao,
    required this.ngayKetThuc,
    required this.beLongTo,
    required this.tenHoSo,
    required this.trangThai,
    required this.nguoiTao,
    required this.quaTrinhXuLy,
    required this.hoSoFiles
  });
  factory HoSo.fromJson(Map<String, dynamic>? json) {
    return HoSo(
        id: json!= null && json['id'] != null? json['id']: 0,
        ngayTao: json!= null &&  json['ngayTao'] != null? json['ngayTao']: '',
        ngayKetThuc: json!= null &&  json['ngayKetThuc'] != null? json['ngayKetThuc']: '',
        beLongTo: json!= null &&  json['beLongTo'] != null? json['beLongTo']: 0,
        tenHoSo: json!= null &&  json['tenHoSo'] != null? json['tenHoSo']: '',
        trangThai: json!= null &&  json['trangThai'] != null? json['trangThai']: 0,
        nguoiTao: Staff.fromJson(json!= null ?json['nguoiTao']: null),
        quaTrinhXuLy: json!= null &&  json['quaTrinhXuLy'] != null? json['quaTrinhXuLy']: '',
        hoSoFiles: json!= null &&  json['hoSoFiles']!=null? (json['hoSoFiles'] as List)
            .map((data) => HoSoFile.fromJson(data))
            .toList(): []
    );
  }
}