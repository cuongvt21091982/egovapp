import 'package:egovapp/model/hoso/hosofilexuly.dart';
import 'package:egovapp/model/staffs/staff.dart';
class HoSoComment
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
  List<HoSoFileXuLy> hoSoFileXuLys;
  HoSoComment({
    required this.id,
    required this.maXLId,
    required this.comment,
    required this.staffId,
    required this.created,
    required this.staffs,
    required this.status,
    required this.soLanDoc,
    required this.thoiGianXem,
    required this.hoSoFileXuLys

  });
  factory HoSoComment.fromJson(Map<String, dynamic>? json) {
    return HoSoComment(
        id: json!= null && json['id'] != null? json['id']: 0,
        maXLId: json!= null &&  json['maXLId'] != null? json['maXLId']: 0,
        comment: json!= null &&  json['comment'] != null? json['comment']: '',
        staffId: json!= null &&  json['staffId'] != null? json['staffId']: 0,
        created: json!= null &&  json['created'] != null? json['created']: '',
        staffs: Staff.fromJson(json!= null ?json['staffs']: null),
        status: json!= null &&  json['status'] != null? json['status']: -1,
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXem: json!= null &&  json['thoiGianXem'] != null? json['thoiGianXem']: '',
        hoSoFileXuLys: json!= null &&  json['hoSoFileXuLys']!=null? (json['hoSoFileXuLys'] as List)
            .map((data) => HoSoFileXuLy.fromJson(data))
            .toList(): []
    );
  }
}