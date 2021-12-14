import 'package:egovapp/model/danhmuc/nhommauvanban.dart';
import 'package:egovapp/model/mauvanban/mauvanbanfile.dart';
class MauVanBan
{
  final int id;
  final int maLoai;
  final String tenVanBan;
  final String ghichu;
  final int nguoiNhapID;
  final int soVanThuID;
  final NhomMauVanBan nhomMauVanBan;
  List<MauVanBanFile> mauVanBanFiles;
  MauVanBan({
    required this.id,
    required this.maLoai,
    required this.tenVanBan,
    required this.ghichu,
    required this.nguoiNhapID,
    required this.soVanThuID,
    required this.nhomMauVanBan,
    required this.mauVanBanFiles

  });
  factory MauVanBan.fromJson(Map<String, dynamic>? json) {
    return MauVanBan(
        id: json!= null && json['id'] != null? json['id']: 0,
        maLoai: json!= null &&  json['maLoai'] != null? json['maLoai']: 0,
        tenVanBan: json!= null &&  json['tenVanBan'] != null? json['tenVanBan']: '',
        ghichu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
        nguoiNhapID: json!= null &&  json['nguoiNhapID'] != null? json['nguoiNhapID']: 0,
        soVanThuID: json!= null &&  json['soVanThuID'] != null? json['soVanThuID']: 0,
        nhomMauVanBan: NhomMauVanBan.fromJson(json!= null ?json['nhomMauVanBan']: null),
        mauVanBanFiles: json!= null &&  json['mauVanBanFiles']!=null? (json['mauVanBanFiles'] as List)
            .map((data) => MauVanBanFile.fromJson(data))
            .toList(): []
    );
  }
}