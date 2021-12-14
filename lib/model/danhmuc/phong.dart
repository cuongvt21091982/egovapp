import 'package:egovapp/model/danhmuc/loaiphong.dart';
import 'package:egovapp/model/danhmuc/toanha.dart';

class Phong
{
  final int id;
  final String tenPhong;
  final int loaiPhongID;
  final int toaNhaID;
  final String sucChua;
  final String thietBi;
  final int stt;
  final ToaNha toaNha;
  final LoaiPhong loaiPhong;
  Phong({
    required this.id,
    required this.tenPhong,
    required this.loaiPhongID,
    required this.toaNhaID,
    required this.sucChua,
    required this.thietBi,
    required this.stt,
    required this.toaNha,
    required this.loaiPhong

  });
  factory Phong.fromJson(Map<String, dynamic>? json) {
    return Phong(
        id: json != null ? json['id'] : -1,
        tenPhong: json != null && json['tenPhong']!=null? json['tenPhong']: '',
        loaiPhongID: json != null && json['loaiPhongID']!=null? json['loaiPhongID']: 0,
        toaNhaID: json != null && json['toaNhaID']!=null? json['toaNhaID']: 0,
        sucChua: json != null && json['sucChua']!=null? json['sucChua']: '',
        thietBi: json != null && json['thietBi']!=null? json['thietBi']: '',
        stt:  json != null ? json['stt'] :-1,
        toaNha: ToaNha.fromJson(json != null &&  json['toaNha']!= null ? json['toaNha']: null),
        loaiPhong: LoaiPhong.fromJson(json != null && json['loaiPhong']!= null ? json['loaiPhong']: null),

    );
  }
}
