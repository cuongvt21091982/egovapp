import 'package:egovapp/model/danhmuc/chucvu.dart';
import 'package:egovapp/model/danhmuc/donvi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Staff
{
  final int  id;
  final String fullName;
  final String hoDem;
  final String ten;
  final String biDanh;
  final String ngaySinh;
  final int gioiTinh;
  final int maDonVi;
  final String chucVu;
  final String telOffice;
  final String telHome;
  final String mobile;
  final String address;
  final String email;
  final String webEmail;
  final String soLanDangNhap;
  final String chuKy;
  final String anh;
  final int thuTu;
  final int suDung;
  final String lstDonvi;
  final String lastAccessTime;
  final ChucVu chucVuItem  ;
  final DonVi donViItem ;

  Staff({
    required this.id,
    required this.fullName,
    required this.hoDem,
    required this.ten,
    required this.biDanh,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.maDonVi,
    required this.chucVu,
    required this.telOffice,
    required this.telHome,
    required this.mobile,
    required this.address,
    required this.email,
    required this.webEmail,
    required this.soLanDangNhap,
    required this.chuKy,
    required this.anh,
    required this.thuTu,
    required this.suDung,
    required this.lstDonvi,
    required this.lastAccessTime,
    required this.chucVuItem,
    required this.donViItem
    });
  factory Staff.fromJson(Map<String, dynamic>? json) {

    return Staff(
      id: json!= null && json['id'] != null? json['id']: 0,
      fullName: json!= null && json['fullName'] != null? json['fullName']: '',
      hoDem: json!= null && json['hoDem'] != null? json['hoDem']: '',
      ten: json!= null && json['ten'] != null? json['ten']: '',
      biDanh: json!= null && json['biDanh'] != null? json['biDanh']: '',
      ngaySinh: json!= null && json['ngaySinh'] != null? json['ngaySinh']: '',
      gioiTinh: json!= null && json['gioiTinh'] != null? json['gioiTinh']: 0,
      maDonVi: json!= null && json['maDonVi'] != null? json['maDonVi']: 0,
      chucVu: json!= null && json['chucVu'] != null? json['chucVu']: '0',
      telOffice: json!= null && json['telOffice'] != null? json['telOffice']: '',
      telHome: json!= null && json['telHome'] != null? json['telHome']: '',
      mobile: json!= null && json['mobile'] != null? json['mobile']: '',
      address: json!= null && json['address'] != null? json['address']: '',
      email: json!= null && json['email'] != null? json['email']: '',
      webEmail: json!= null && json['webEmail'] != null? json['webEmail']: '',
      soLanDangNhap: json!= null && json['soLanDangNhap'] != null? json['soLanDangNhap']: '',
      chuKy: json!= null && json['chuKy'] != null? json['chuKy']: '',
      anh: json!= null && json['anh'] != null? json['anh']: '',
      thuTu: json!= null && json['thuTu'] != null? json['thuTu']: 0,
      suDung: json!= null && json['suDung'] != null? json['suDung']: 0,
      lstDonvi: json!= null && json['lstDonvi'] != null? json['lstDonvi']: '',
      lastAccessTime: json!= null && json['lastAccessTime'] != null? json['lastAccessTime']: '',
      chucVuItem: ChucVu.fromJson(json!=null && json['chucVuItem']!= null ?json['chucVuItem']: null),
      donViItem: DonVi.fromJson(json!=null && json['donViItem']!= null ? json['donViItem']: null)
    );
  }
}
