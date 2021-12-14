import 'package:egovapp/model/hoso/hosofilexuly.dart';
import 'package:egovapp/model/staffs/staff.dart';
class HoSoShare
{
  final int id;
  final int hosoID;
  final int beLongTo;
  final String shareForUserID;
  final bool reView;
  final String comment;

  HoSoShare({
    required this.id,
    required this.hosoID,
    required this.beLongTo,
    required this.shareForUserID,
    required this.reView,
    required this.comment
  });
  factory HoSoShare.fromJson(Map<String, dynamic>? json) {
    return HoSoShare(
        id: json!= null && json['id'] != null? json['id']: 0,
        hosoID: json!= null &&  json['hosoID'] != null? json['hosoID']: 0,
        beLongTo: json!= null &&  json['beLongTo'] != null? json['beLongTo']: 0,
        shareForUserID: json!= null &&  json['shareForUserID'] != null? json['shareForUserID']: '',
        reView: json!= null &&  json['reView'] != null? json['reView']: false,
        comment: json!= null &&  json['comment'] != null? json['comment']: ''
    );
  }
}