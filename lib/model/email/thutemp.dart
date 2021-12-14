import 'package:egovapp/model/email/thufile.dart';
import 'package:egovapp/model/staffs/staff.dart';
class ThuTemp
{
  final int id;
  final String vanDe;
  final String noiDung;
  final String noiDungShort;
  final String ngayNhap;
  final int nguoiTao;
  final String tenNguoitao;
  final int nguoiNhan;
  final String nguoinhanTen;
  final String timeAd;
  final String timeReply;
  final String thoiHan;
  final int checkread;
  final int suDung;
  final String ngayTao;
  final int flagConfirm;
  final Staff nguoiNhanItem;
  final Staff nguoiTaoItem;
  List<ThuFile> thuFiles;
  ThuTemp({
    required this.id,
    required this.vanDe,
    required this.noiDung,
    required this.noiDungShort,
    required this.ngayNhap,
    required this.nguoiTao,
    required this.tenNguoitao,
    required this.nguoiNhan,
    required this.nguoinhanTen,
    required this.timeAd,
    required this.timeReply,
    required this.thoiHan,
    required this.checkread,
    required this.suDung,
    required this.ngayTao,
    required this.flagConfirm,
    required this.nguoiNhanItem,
    required this.nguoiTaoItem,
    required this.thuFiles,
  });
  factory ThuTemp.fromJson(Map<String, dynamic>? json) {
    return ThuTemp(
        id: json!= null && json['id'] != null? json['id']: 0,
        vanDe: json!= null &&  json['vanDe'] != null? json['vanDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        noiDungShort: json!= null &&  json['noiDungShort'] != null? json['noiDungShort']: '',
        ngayNhap: json!= null &&  json['ngayNhap'] != null? json['ngayNhap']: '',
        nguoiTao: json!= null &&  json['nguoiTao'] != null? json['nguoiTao']: 0,
        tenNguoitao: json!= null &&  json['tenNguoitao'] != null? json['tenNguoitao']: '',
        nguoiNhan: json!= null &&  json['nguoiNhan'] != null? json['nguoiNhan']: 0,
        nguoinhanTen: json!= null &&  json['nguoinhanTen'] != null? json['nguoinhanTen']: '',
        timeAd: json!= null &&  json['timeAd'] != null? json['timeAd']: '',
        timeReply: json!= null &&  json['timeReply'] != null? json['timeReply']: '',
        thoiHan: json!= null &&  json['thoiHan'] != null? json['thoiHan']: '',
        checkread: json!= null &&  json['checkread'] != null? json['checkread']: 0,
        suDung: json!= null &&  json['suDung'] != null? json['suDung']: 0,
        ngayTao: json!= null &&  json['ngayTao'] != null? json['ngayTao']: '',
        flagConfirm: json!= null &&  json['flagConfirm'] != null? json['flagConfirm']: 0,
        nguoiNhanItem:  Staff.fromJson(json!= null ?json['nguoiNhanItem']: null),
        nguoiTaoItem:  Staff.fromJson(json!= null ?json['nguoiTaoItem']: null),
        thuFiles: json!= null &&  json['thuFiles']!=null? (json['thuFiles'] as List)
            .map((data) => ThuFile.fromJson(data))
            .toList(): []
    );
  }
}
