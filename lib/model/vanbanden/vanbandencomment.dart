import 'package:egovapp/model/meeting/meetingfilexuly.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/vanbanden/vanbandenfilexuly.dart';
class VanBanDenComment
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
  final int capXuLy;
  final int maChuTri;
  final Staff nguoiChuTri;
  List<VanBanDenFileXuLy> vanBanDenXLFiles;
  VanBanDenComment({
    required this.id,
    required this.maXLId,
    required this.comment,
    required this.staffId,
    required this.created,
    required this.staffs,
    required this.status,
    required this.soLanDoc,
    required this.thoiGianXem,
    required this.capXuLy,
    required this.maChuTri,
    required this.nguoiChuTri,
    required this.vanBanDenXLFiles

  });
  factory VanBanDenComment.fromJson(Map<String, dynamic>? json) {
    return VanBanDenComment(
        id: json!= null && json['id'] != null? json['id']: 0,
        maXLId: json!= null &&  json['maXLId'] != null? json['maXLId']: '',
        comment: json!= null &&  json['comment'] != null? json['comment']: '',
        staffId: json!= null &&  json['staffId'] != null? json['staffId']: 0,
        created: json!= null &&  json['created'] != null? json['created']: '',
        staffs: Staff.fromJson(json!= null ?json['staffs']: null),
        status: json!= null &&  json['status'] != null? json['status']: -1,
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXem: json!= null &&  json['thoiGianXem'] != null? json['thoiGianXem']: '',
        capXuLy: json!= null &&  json['capXuLy'] != null? json['capXuLy']: 0,
        maChuTri: json!= null &&  json['maChuTri'] != null? json['maChuTri']: 0,
        nguoiChuTri: Staff.fromJson(json!= null ?json['nguoiChuTri']: null),
        vanBanDenXLFiles: json!= null &&  json['vanBanDenXLFiles']!=null? (json['vanBanDenXLFiles'] as List)
            .map((data) => VanBanDenFileXuLy.fromJson(data))
            .toList(): []
    );
  }
}