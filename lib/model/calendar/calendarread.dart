import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/model/calendar/calendarfile.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/totrinh/totrinhfile.dart';

class CalendarRead
{
  final int id;
  final int weekID;
  final int yearID;
  final String yKien;
  final int staffID;
  final int soLanDoc;
  final String thoiGianXemLanDau;
  final String thoiGianXemLanCuoi;
  final Staff staffs;
  CalendarRead({
    required this.id,
    required this.weekID,
    required this.yearID,
    required this.yKien,
    required this.staffID,
    required this.soLanDoc,
    required this.thoiGianXemLanDau,
    required this.thoiGianXemLanCuoi,
    required this.staffs
  });
  factory CalendarRead.fromJson(Map<String, dynamic>? json) {
    return CalendarRead(
        id: json!= null && json['id'] != null? json['id']: 0,
        weekID: json!= null &&  json['weekID'] != null? json['weekID']: 0,
        yearID: json!= null &&  json['yearID'] != null? json['yearID']: 0,
        yKien: json!= null &&  json['yKien'] != null? json['yKien']: '',
        staffID: json!= null &&  json['staffID'] != null? json['staffID']: 0,
        soLanDoc: json!= null &&  json['soLanDoc'] != null? json['soLanDoc']: 0,
        thoiGianXemLanDau: json!= null &&  json['thoiGianXemLanDau'] != null? json['thoiGianXemLanDau']: '',
        thoiGianXemLanCuoi: json!= null &&  json['thoiGianXemLanCuoi'] != null? json['thoiGianXemLanCuoi']: '',
        staffs:  Staff.fromJson(json!= null ?json['staffs']: null)
    );
  }
}
