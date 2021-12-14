import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/calendar/calendar.dart';
import 'package:egovapp/model/calendar/calendardepart.dart';
import 'package:egovapp/model/calendar/calendardepartlog.dart';
import 'package:egovapp/model/calendar/calendardepartweek.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/calendardepart';
class ServiceCalendarDepart
{


  Future<List<CalendarDepart>> getPagingSearch(String keyword, String tuNgay,String denNgay,String donViShare, int status,int suDung, int donViId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbysearchpaging?keyword=${keyword}&fdate=${tuNgay}&tdate=${denNgay}&sid=${donViShare}&st=${status}&sd=${suDung}&uid=${donViId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarDepart.fromJson(e)).toList();

  }
  Future<int> getCountSearch(String keyword, String tuNgay,String denNgay,String donViShare, int status,int suDung, int donViId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbysearch?keyword=${keyword}&fdate=${tuNgay}&tdate=${denNgay}&sid=${donViShare}&st=${status}&sd=${suDung}&uid=${donViId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<CalendarDepartWeek>> getDataByWeekYear(int week, int year,String donViShare, int status,int suDung, int donViId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getdatabyweekyear?w=${week}&y=${year}&sid=${donViShare}&st=${status}&sd=${suDung}&uid=${donViId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarDepartWeek.fromJson(e)).toList();

  }
  Future<List<CalendarDepart>> findByMonth(int month, int year,int donViId, int status,int suDung) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findallbymonth?m=${month}&y=${year}&uid=${donViId}&st=${status}&sd=${suDung}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarDepart.fromJson(e)).toList();

  }
  Future<List<CalendarDepartLog>> findByLogId(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findbylog/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarDepartLog.fromJson(e)).toList();

  }
  Future<CalendarDepart> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return CalendarDepart.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<Message> delete(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/delete/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<CalendarDepart> add(DateTime? tuNgay, String tuGio, DateTime? denNgay, String denGio,
      String noiDung,String diaDiem,String chuTri,String ghiChu, String bgColor, int beLongTo, int trangThai, int suDung ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'tuNgay': tuNgay,
          'tuGio': tuGio,
          'denNgay': denNgay,
          'denGio': denGio,
          'noiDung': noiDung,
          'diaDiem': diaDiem,
          'chuTri': chuTri,
          'ghiChu': ghiChu,
          'bgColor': bgColor,
          'beLongTo': beLongTo,
          'trangThai': trangThai,
          'suDung': suDung
        })
    );
    return CalendarDepart.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<CalendarDepart> update(int id, DateTime? tuNgay, String tuGio, DateTime? denNgay, String denGio,
      String noiDung,String diaDiem,String chuTri,String ghiChu, String bgColor, int beLongTo, int trangThai, int suDung) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'tuNgay': tuNgay,
          'tuGio': tuGio,
          'denNgay': denNgay,
          'denGio': denGio,
          'noiDung': noiDung,
          'diaDiem': diaDiem,
          'chuTri': chuTri,
          'ghiChu': ghiChu,
          'bgColor': bgColor,
          'beLongTo': beLongTo,
          'trangThai': trangThai,
          'suDung': suDung
        })
    );
    return CalendarDepart.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
