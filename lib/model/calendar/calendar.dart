import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/model/calendar/calendarfile.dart';
import 'package:egovapp/model/staffs/staff.dart';
class Calendar
{
  final int id;
  final int weekID;
  final String ngay;
  final String thoiGian;
  final DateTime? tuNgay;
  final String tuGio;
  final DateTime? denNgay;
  final String denGio;
  final String noiDung;
  final String chuTri;
  final String diaDiem;
  final String ghiChu;
  final int beLongTo;
  final String caLog;
  final int trangThai;
  final int suDung;
  final int soLuotDoc;
  final String userRead;
  final String bgColor;
  final Staff nguoiTao;
  List<CalendarFile> calendarFiles;
  Calendar({
    required this.id,
    required this.weekID,
    required this.ngay,
    required this.thoiGian,
    required this.tuNgay,
    required this.tuGio,
    required this.denNgay,
    required this.denGio,
    required this.noiDung,
    required this.chuTri,
    required this.diaDiem,
    required this.ghiChu,
    required this.beLongTo,
    required this.caLog,
    required this.soLuotDoc,
    required this.trangThai,
    required this.suDung,
    required this.userRead,
    required this.bgColor,
    required this.nguoiTao,
    required this.calendarFiles
  });
  factory Calendar.fromJson(Map<String, dynamic>? json) {
    return Calendar(
        id: json!= null && json['id'] != null? json['id']: 0,
        weekID: json!= null &&  json['weekID'] != null? json['weekID']: 0,
        ngay: json!= null &&  json['ngay'] != null? json['ngay']: '',
        thoiGian: json!= null &&  json['thoiGian'] != null? json['thoiGian']: '',
        tuNgay: json!= null && json['tuNgay'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['tuNgay'].toString()): null,
        tuGio: json!= null &&  json['tuGio'] != null? json['tuGio']: '',
        denNgay: json!= null && json['denNgay'] != null? FormatUtils.formatDateYYYYMMDDHHMMSS(json['denNgay'].toString()): null,
        denGio: json!= null &&  json['denGio'] != null? json['denGio']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        chuTri: json!= null &&  json['chuTri'] != null? json['chuTri']: '',
        diaDiem: json!= null &&  json['diaDiem'] != null? json['diaDiem']: '',
        ghiChu: json!= null &&  json['ghiChu'] != null? json['ghiChu']: '',
        beLongTo: json!= null &&  json['beLongTo'] != null? json['beLongTo']: 0,
        caLog: json!= null &&  json['caLog'] != null? json['caLog']: '',
        soLuotDoc: json!= null &&  json['soLuotDoc'] != null? json['soLuotDoc']: 0,
        trangThai: json!= null &&  json['trangThai'] != null? json['trangThai']: 0,
        suDung: json!= null &&  json['suDung'] != null? json['suDung']: 0,
        userRead: json!= null &&  json['userRead'] != null? json['userRead']: '',
        bgColor: json!= null &&  json['bgColor'] != null? json['bgColor']: '',
        nguoiTao:  Staff.fromJson(json!= null ?json['nguoiTao']: null),
        calendarFiles: json!= null &&  json['calendarFiles']!=null? (json['calendarFiles'] as List)
            .map((data) => CalendarFile.fromJson(data))
            .toList(): []
    );
  }
}