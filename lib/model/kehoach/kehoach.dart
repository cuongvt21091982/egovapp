import 'package:egovapp/model/danhmuc/loaikehoach.dart';
import 'package:egovapp/model/kehoach/kehoachfile.dart';

class KeHoach
{
  final int id;
  final int loaiKH;
  final String tenKH;
  final String noiDungKH;
  final String ghiChu;
  final int nguoiNhap;
  final int phoCap;
  final int soVanThuID;
  final LoaiKeHoach loaiKeHoach;
  List<KeHoachFile> keHoachFiles;
  KeHoach({
    required this.id,
    required this.loaiKH,
    required this.tenKH,
    required this.noiDungKH,
    required this.ghiChu,
    required this.nguoiNhap,
    required this.phoCap,
    required this.soVanThuID,
    required this.loaiKeHoach,
    required this.keHoachFiles

  });
  factory KeHoach.fromJson(Map<String, dynamic>? json) {
    return KeHoach(
        id: json!= null && json['id'] != null? json['id']: 0,
        loaiKH: json!= null &&  json['loaiKH'] != null? json['loaiKH']: 0,
        tenKH: json!= null &&  json['tenKH'] != null? json['tenKH']: '',
        noiDungKH: json!= null &&  json['noiDungKH'] != null? json['noiDungKH']: '',
        ghiChu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
        nguoiNhap: json!= null &&  json['nguoiNhap'] != null? json['nguoiNhap']: 0,
        phoCap: json!= null &&  json['phoCap'] != null? json['phoCap']: 0,
        soVanThuID: json!= null &&  json['soVanThuID'] != null? json['soVanThuID']: 0,
        loaiKeHoach: LoaiKeHoach.fromJson(json!= null ?json['loaiKeHoach']: null),
        keHoachFiles: json!= null &&  json['keHoachFiles']!=null? (json['keHoachFiles'] as List)
            .map((data) => KeHoachFile.fromJson(data))
            .toList(): []
    );
  }
}