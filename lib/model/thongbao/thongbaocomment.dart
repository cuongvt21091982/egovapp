import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/thongbao/thongbaofilexuly.dart';
class ThongBaoComment
{
  final int id;
  final int maXLId;
  final String comment;
  final int staffId;
  final String created;
  final Staff staffs;
  final int status;
  final int soLanDoc;
  final String thoiGianXem;
  List<ThongBaoFileXuLy> thongBaoFileXuLys;
  ThongBaoComment({
    required this.id,
    required this.maXLId,
    required this.comment,
    required this.staffId,
    required this.created,
    required this.staffs,
    required this.status,
    required this.soLanDoc,
    required this.thoiGianXem,
    required this.thongBaoFileXuLys

  });
  factory ThongBaoComment.fromJson(Map<String, dynamic>? json) {
    return ThongBaoComment(
        id: json!= null && json['id'] != null? json['id']: 0,
        maXLId: json!= null &&  json['maXLId'] != null? json['maXLId']: '',
        comment: json!= null &&  json['comment'] != null? json['comment']: '',
        staffId: json!= null &&  json['staffId'] != null? json['staffId']: 0,
        created: json!= null &&  json['created'] != null? json['created']: '',
        staffs: Staff.fromJson(json!= null ?json['staffs']: null),
        status: json!= null &&  json['status'] != null? json['status']: -1,
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXem: json!= null &&  json['thoiGianXem'] != null? json['thoiGianXem']: '',
        thongBaoFileXuLys: json!= null &&  json['thongBaoFileXuLys']!=null? (json['thongBaoFileXuLys'] as List)
            .map((data) => ThongBaoFileXuLy.fromJson(data))
            .toList(): []
    );
  }
}