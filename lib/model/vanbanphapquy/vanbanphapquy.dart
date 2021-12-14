import 'package:egovapp/model/danhmuc/nhommauvanban.dart';
import 'package:egovapp/model/mauvanban/mauvanbanfile.dart';
import 'package:egovapp/model/vanbanphapquy/vanbanphapquyfile.dart';
class VanBanPhapQuy
{
  final int id;
  final String soHieuGoc;
  final String ngayVaoSo;
  final String ngayKy;
  final String trichYeu;
  final String noiGui;
  final String usersRead;
  final int soLuotDoc;
  final String dViDuocDoc;
  final int maLoaiVB;
  final String nguoiKy;
  final int nguoiVaoSoID;
  final int soVanThuID;
  List<VanBanBanQuyFile> vanBanPhapQuyFiles;
  VanBanPhapQuy({
    required this.id,
    required this.soHieuGoc,
    required this.ngayVaoSo,
    required this.ngayKy,
    required this.trichYeu,
    required this.noiGui,
    required this.usersRead,
    required this.soLuotDoc,
    required this.dViDuocDoc,
    required this.maLoaiVB,
    required this.nguoiKy,
    required this.nguoiVaoSoID,
    required this.soVanThuID,
    required this.vanBanPhapQuyFiles

  });
  factory VanBanPhapQuy.fromJson(Map<String, dynamic>? json) {
    return VanBanPhapQuy(
        id: json!= null && json['id'] != null? json['id']: 0,
        soHieuGoc: json!= null &&  json['soHieuGoc'] != null? json['soHieuGoc']: '',
        ngayVaoSo: json!= null &&  json['ngayVaoSo'] != null? json['ngayVaoSo']: '',
        ngayKy: json!= null &&  json['ngayKy'] != null? json['ngayKy']: '',
        trichYeu: json!= null &&  json['trichYeu'] != null? json['trichYeu']: '',
        noiGui: json!= null &&  json['noiGui'] != null? json['noiGui']: '',
        usersRead: json!= null &&  json['usersRead'] != null? json['usersRead']: '',
        soLuotDoc: json!= null &&  json['soLuotDoc'] != null? json['soLuotDoc']: 0,
        dViDuocDoc: json!= null &&  json['dViDuocDoc'] != null? json['dViDuocDoc']: '',
        maLoaiVB: json!= null &&  json['maLoaiVB'] != null? json['maLoaiVB']: 0,
        nguoiKy: json!= null &&  json['nguoiKy'] != null? json['nguoiKy']: '',
        nguoiVaoSoID: json!= null &&  json['nguoiVaoSoID'] != null? json['nguoiVaoSoID']: 0,
        soVanThuID: json!= null &&  json['soVanThuID'] != null? json['soVanThuID']: 0,
        vanBanPhapQuyFiles: json!= null &&  json['vanBanPhapQuyFiles']!=null? (json['vanBanPhapQuyFiles'] as List)
            .map((data) => VanBanBanQuyFile.fromJson(data))
            .toList(): []
    );
  }
}