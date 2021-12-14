import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/vanbandi/nhomvanbandi.dart';
import 'package:egovapp/model/vanbandi/vanbandifile.dart';

class VanBanDi
{
  final int id;
  final int maNhomVBdi;
  final String soVaoSo;
  final String trichYeu;
  final String ngayKy;
  final int maNguoiKy;
  final String ngayVaoSo;
  final int maLoaiVB;
  final int maLinhVuc;
  final int maDoMat;
  final int maDoKhan;
  final String noiNhan;
  final int maNguoiSoanThao;
  final String thoiHan;
  final int maNguoiChuTri;
  final String noiDungXL;
  final int maTrangThaiXL;
  final String ghiChu;
  final int phoCap;
  final String usersRead;
  final int soLuotDoc;
  final int maVBGoc;
  final String loiNhanVT;
  final int kieuDuThao;
  final int maNguoiDG;
  final int xepLoaiDG;
  final int suDung;
  final int choXem;
  final int nguoiNhapID;
  final int soVanThuID;
  final Staff nguoiKy;
  final NhomVanBanDi nhomVanBanDi;
  final Staff nguoiChuTri;
  List<VanBanDiFile> vanBanDiFiles;
  VanBanDi({
    required this.id,
    required this.maNhomVBdi,
    required this.soVaoSo,
    required this.trichYeu,
    required this.ngayKy,
    required this.maNguoiKy,
    required this.ngayVaoSo,
    required this.maLoaiVB,
    required this.maLinhVuc,
    required this.maDoMat,
    required this.maDoKhan,
    required this.noiNhan,
    required this.maNguoiSoanThao,
    required this.thoiHan,
    required this.maNguoiChuTri,
    required this.noiDungXL,
    required this.maTrangThaiXL,
    required this.ghiChu,
    required this.phoCap,
    required this.usersRead,
    required this.soLuotDoc,
    required this.maVBGoc,
    required this.loiNhanVT,
    required this.kieuDuThao,
    required this.maNguoiDG,
    required this.xepLoaiDG,
    required this.suDung,
    required this.choXem,
    required this.nguoiNhapID,
    required this.soVanThuID,
    required this.nguoiKy,
    required this.nhomVanBanDi,
    required this.nguoiChuTri,
    required this.vanBanDiFiles,
  });
  factory VanBanDi.fromJson(Map<String, dynamic>? json) {
    return VanBanDi(
        id: json!= null && json['id'] != null? json['id']: 0,
        maNhomVBdi: json!= null && json['maNhomVBdi'] != null? json['maNhomVBdi']: 0,
        soVaoSo: json!= null &&  json['soVaoSo'] != null? json['soVaoSo']: '',
        trichYeu: json!= null &&  json['trichYeu'] != null? json['trichYeu']: '',
        ngayKy: json!= null &&  json['ngayKy'] != null? json['ngayKy']: '',
        maNguoiKy: json!= null &&  json['maNguoiKy'] != null? json['maNguoiKy']: 0,
        ngayVaoSo: json!= null &&  json['ngayVaoSo'] != null? json['ngayVaoSo']: '',
        maLoaiVB: json!= null &&  json['maLoaiVB'] != null? json['maLoaiVB']: 0,
        maLinhVuc: json!= null &&  json['maLinhVuc'] != null? json['maLinhVuc']: 0,
        maDoMat: json!= null &&  json['maDoMat'] != null? json['maDoMat']: 0,
        maDoKhan: json!= null &&  json['maDoKhan'] != null? json['maDoKhan']: 0,
        noiNhan: json!= null &&  json['noiNhan'] != null? json['noiNhan']: '',
        maNguoiSoanThao: json!= null &&  json['maNguoiSoanThao'] != null? json['maNguoiSoanThao']: 0,
        thoiHan: json!= null &&  json['thoiHan'] != null? json['thoiHan']: '',
        maNguoiChuTri: json!= null &&  json['maNguoiChuTri'] != null? json['maNguoiChuTri']: 0,
        noiDungXL: json!= null &&  json['noiDungXL'] != null? json['noiDungXL']: '',
        maTrangThaiXL: json!= null &&  json['maTrangThaiXL'] != null? json['maTrangThaiXL']: 0,
        ghiChu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
        phoCap: json!= null &&  json['phoCap'] != null? json['phoCap']: 0,
        usersRead: json!= null &&  json['usersRead'] != null? json['usersRead']: '',
        soLuotDoc: json!= null &&  json['soLuotDoc'] != null? json['soLuotDoc']: 0,
        maVBGoc: json!= null &&  json['maVBGoc'] != null? json['maVBGoc']: 0,
        loiNhanVT: json!= null &&  json['loiNhanVT'] != null? json['loiNhanVT']: '',
        kieuDuThao: json!= null &&  json['kieuDuThao'] != null? json['kieuDuThao']: 0,
        maNguoiDG: json!= null &&  json['maNguoiDG'] != null? json['maNguoiDG']: 0,
        xepLoaiDG: json!= null &&  json['xepLoaiDG'] != null? json['xepLoaiDG']: 0,
        suDung: json!= null &&  json['suDung'] != null? json['suDung']: 0,
        choXem: json!= null &&  json['choXem'] != null? json['choXem']: 0,
        nguoiNhapID: json!= null &&  json['nguoiNhapID'] != null? json['nguoiNhapID']: 0,
        soVanThuID: json!= null &&  json['soVanThuID'] != null? json['soVanThuID']: 0,
        nguoiKy: Staff.fromJson(json!= null ?json['nguoiKy']: null),
        nhomVanBanDi: NhomVanBanDi.fromJson(json!= null ?json['nhomVanBanDi']: null),
        nguoiChuTri: Staff.fromJson(json!= null ?json['nguoiChuTri']: null),
        vanBanDiFiles: json!= null &&  json['vanBanDiFiles']!=null? (json['vanBanDiFiles'] as List)
            .map((data) => VanBanDiFile.fromJson(data))
            .toList(): []
    );
  }
}