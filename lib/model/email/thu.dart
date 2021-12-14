import 'package:egovapp/model/email/thufile.dart';
import 'package:egovapp/model/staffs/staff.dart';
class Thu
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
  final String nguoiNhanID;
  final String timeAd;
  final String timeReply;
  final String thoiHan;
  final int checkread;
  final int suDung;
  final String ngayTao;
  final int nhomThu;
  final int flagConfirm;
  final Staff nguoiGui;
  final int status;
  final int replyId;
  final int thuGoc;
  final int ghim;
  final Staff nguoiNhanThu;
  List<ThuFile> thuFiles;
  Thu({
    required this.id,
    required this.vanDe,
    required this.noiDung,
    required this.noiDungShort,
    required this.ngayNhap,
    required this.nguoiTao,
    required this.tenNguoitao,
    required this.nguoiNhan,
    required this.nguoinhanTen,
    required this.nguoiNhanID,
    required this.timeAd,
    required this.timeReply,
    required this.thoiHan,
    required this.checkread,
    required this.suDung,
    required this.ngayTao,
    required this.nhomThu,
    required this.flagConfirm,
    required this.nguoiGui,
    required this.status,
    required this.replyId,
    required this.thuGoc,
    required this.ghim,
    required this.nguoiNhanThu,
    required this.thuFiles,
  });
  factory Thu.fromJson(Map<String, dynamic>? json) {
    return Thu(
        id: json!= null && json['id'] != null? json['id']: 0,
        vanDe: json!= null &&  json['vanDe'] != null? json['vanDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        noiDungShort: json!= null &&  json['noiDungShort'] != null? json['noiDungShort']: '',
        ngayNhap: json!= null &&  json['ngayNhap'] != null? json['ngayNhap']: '',
        nguoiTao: json!= null &&  json['nguoiTao'] != null? json['nguoiTao']: 0,
        tenNguoitao: json!= null &&  json['tenNguoitao'] != null? json['tenNguoitao']: '',
        nguoiNhan: json!= null &&  json['nguoiNhan'] != null? json['nguoiNhan']: 0,
        nguoinhanTen: json!= null &&  json['nguoinhanTen'] != null? json['nguoinhanTen']: '',
        nguoiNhanID: json!= null &&  json['nguoiNhanID'] != null? json['nguoiNhanID']: '',
        timeAd: json!= null &&  json['timeAd'] != null? json['timeAd']: '',
        timeReply: json!= null &&  json['timeReply'] != null? json['timeReply']: '',
        thoiHan: json!= null &&  json['thoiHan'] != null? json['thoiHan']: '',
        checkread: json!= null &&  json['checkread'] != null? json['checkread']: 0,
        suDung: json!= null &&  json['suDung'] != null? json['suDung']: 0,
        ngayTao: json!= null &&  json['ngayTao'] != null? json['ngayTao']: '',
        nhomThu: json!= null &&  json['nhomThu'] != null? json['nhomThu']: 0,
        flagConfirm: json!= null &&  json['flagConfirm'] != null? json['flagConfirm']: 0,
        nguoiGui:  Staff.fromJson(json!= null ?json['nguoiGui']: null),
        status: json!= null &&  json['status'] != null? json['status']: 0,
        replyId: json!= null &&  json['replyId'] != null? json['replyId']: 0,
        thuGoc: json!= null &&  json['thuGoc'] != null? json['thuGoc']: 0,
        ghim: json!= null &&  json['ghim'] != null? json['ghim']: 0,
        nguoiNhanThu:  Staff.fromJson(json!= null ?json['nguoiNhanThu']: null),
        thuFiles: json!= null &&  json['thuFiles']!=null? (json['thuFiles'] as List)
            .map((data) => ThuFile.fromJson(data))
            .toList(): []
    );
  }
}
