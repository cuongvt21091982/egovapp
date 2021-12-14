
import 'package:egovapp/model/danhmuc/dokhan.dart';
import 'package:egovapp/model/danhmuc/domat.dart';
import 'package:egovapp/model/danhmuc/donvingoai.dart';
import 'package:egovapp/model/meeting/meetingfile.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/vanbanden/vanbandenfile.dart';

class VanBanDen
{
  final int id;
  final String soVaoSo;
  final String soHieuGoc;
  final String trichYeu;
  final int maLoaiVB;
  final int maLinhVuc;
  final int maDoMat;
  final int maDoKhan;
  final int maNoiGui;
  final DonViNgoai noiPhatHanh;
  final String ngayKy;
  final String nguoiKy;
  final String ngayNhan;
  final String nguoiNhan;
  final String ngayVaoSo;
  final String thoiHan;
  final int maNguoiChuTri;
  final String noiDungXL;
  final String ghiChu;
  final int maTrangThaiXL;
  final int phoCap;
  final int maNguoiDG;
  final int xepLoaiDG;
  final int suDung;
  final String thongTinKhac;
  final int choXem;
  final String noiLuu;
  final String usersRead;
  final int soLuotDoc;
  final int nguoiNhapID;
  final int soVanThuID;
  final String logVanBan;
  final String userDuocXemIDs;
  final DoKhan doKhan;
  final DoMat doMat;
  final Staff nguoiChuTri;
  List<VanBanDenFile> vanBanDenFiles;
  VanBanDen({
    required this.id,
    required this.soVaoSo,
    required this.soHieuGoc,
    required this.trichYeu,
    required this.maLoaiVB,
    required this.maLinhVuc,
    required this.maDoMat,
    required this.maDoKhan,
    required this.maNoiGui,
    required this.noiPhatHanh,
    required this.ngayKy,
    required this.nguoiKy,
    required this.ngayNhan,
    required this.nguoiNhan,
    required this.ngayVaoSo,
    required this.thoiHan,
    required this.maNguoiChuTri,
    required this.noiDungXL,
    required this.ghiChu,
    required this.maTrangThaiXL,
    required this.phoCap,
    required this.maNguoiDG,
    required this.xepLoaiDG,
    required this.suDung,
    required this.thongTinKhac,
    required this.choXem,
    required this.noiLuu,
    required this.usersRead,
    required this.soLuotDoc,
    required this.nguoiNhapID,
    required this.soVanThuID,
    required this.logVanBan,
    required this.userDuocXemIDs,
    required this.doKhan,
    required this.doMat,
    required this.nguoiChuTri,
    required this.vanBanDenFiles,
  });
  factory VanBanDen.fromJson(Map<String, dynamic>? json) {
    return VanBanDen(
        id: json!= null && json['id'] != null? json['id']: 0,
        soVaoSo: json!= null &&  json['soVaoSo'] != null? json['soVaoSo']: '',
        soHieuGoc: json!= null &&  json['soHieuGoc'] != null? json['soHieuGoc']: '',
        trichYeu: json!= null &&  json['trichYeu'] != null? json['trichYeu']: '',
        maLoaiVB: json!= null &&  json['maLoaiVB'] != null? json['maLoaiVB']: 0,
        maLinhVuc: json!= null &&  json['maLinhVuc'] != null? json['maLinhVuc']: 0,
        maDoMat: json!= null &&  json['maDoMat'] != null? json['maDoMat']: 0,
        maDoKhan: json!= null &&  json['maDoKhan'] != null? json['maDoKhan']: 0,
        maNoiGui: json!= null &&  json['maNoiGui'] != null? json['maNoiGui']: 0,
        noiPhatHanh: DonViNgoai.fromJson(json!= null ?json['noiPhatHanh']: null),
        ngayKy: json!= null &&  json['ngayKy'] != null? json['ngayKy']: '',
        nguoiKy: json!= null &&  json['nguoiKy'] != null? json['nguoiKy']: '',
        ngayNhan: json!= null &&  json['ngayNhan'] != null? json['ngayNhan']: '',
        nguoiNhan: json!= null &&  json['nguoiNhan'] != null? json['nguoiNhan']: '',
        ngayVaoSo: json!= null &&  json['ngayVaoSo'] != null? json['ngayVaoSo']: '',
        thoiHan: json!= null &&  json['thoiHan'] != null? json['thoiHan']: '',
        maNguoiChuTri: json!= null &&  json['maNguoiChuTri'] != null? json['maNguoiChuTri']: 0,
        noiDungXL: json!= null &&  json['noiDungXL'] != null? json['noiDungXL']: '',
        ghiChu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
        maTrangThaiXL: json!= null &&  json['maTrangThaiXL'] != null? json['maTrangThaiXL']: 0,
        phoCap: json!= null &&  json['phoCap'] != null? json['phoCap']: 0,
        maNguoiDG: json!= null &&  json['maNguoiDG'] != null? json['maNguoiDG']: 0,
        xepLoaiDG: json!= null &&  json['xepLoaiDG'] != null? json['xepLoaiDG']: 0,
        suDung: json!= null &&  json['suDung'] != null? json['suDung']: 0,
        thongTinKhac: json!= null &&  json['thongTinKhac'] != null? json['thongTinKhac']: '',
        choXem: json!= null &&  json['choXem'] != null? json['choXem']: 0,
        noiLuu: json!= null &&  json['noiLuu'] != null? json['noiLuu']: '',
        usersRead: json!= null &&  json['usersRead'] != null? json['usersRead']: '',
        soLuotDoc: json!= null &&  json['soLuotDoc'] != null? json['soLuotDoc']: 0,
        nguoiNhapID: json!= null &&  json['nguoiNhapID'] != null? json['nguoiNhapID']: 0,
        soVanThuID: json!= null &&  json['soVanThuID'] != null? json['soVanThuID']: 0,
        logVanBan: json!= null &&  json['logVanBan'] != null? json['logVanBan']: '',
        userDuocXemIDs: json!= null &&  json['userDuocXemIDs'] != null? json['userDuocXemIDs']: '',
        doKhan: DoKhan.fromJson(json!= null ?json['doKhan']: null),
        doMat: DoMat.fromJson(json!= null ?json['doMat']: null),
        nguoiChuTri: Staff.fromJson(json!= null ?json['nguoiChuTri']: null),
        vanBanDenFiles: json!= null &&  json['vanBanDenFiles']!=null? (json['vanBanDenFiles'] as List)
            .map((data) => VanBanDenFile.fromJson(data))
            .toList(): []
    );
  }
}