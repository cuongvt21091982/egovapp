import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/calendar/calendarnews.dart';
import 'package:egovapp/model/calendar/calendarnewslog.dart';
import 'package:egovapp/model/calendar/calendarnewsweek.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/calendarnews';
class ServiceCalendarNews
{
  Future<List<CalendarNews>> getPagingSearch(String keyword, String tuNgay,String denNgay,int staffId, int status,int suDung, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbysearchpaging?keyword=${keyword}&fdate=${tuNgay}&tdate=${denNgay}&uid=${staffId}&st=${status}&sd=${suDung}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarNews.fromJson(e)).toList();

  }
  Future<int> getCountSearch(String keyword, String tuNgay,String denNgay,int staffId, int status,int suDung) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbysearch?keyword=${keyword}&fdate=${tuNgay}&tdate=${denNgay}&uid=${staffId}&st=${status}&sd=${suDung}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<CalendarNewsWeek>> getDataByWeekYear(int week, int year,int staffId, int status,int suDung) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getdatabyweekyear?w=${week}&y=${year}&uid=${staffId}&st=${status}&sd=${suDung}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarNewsWeek.fromJson(e)).toList();

  }
  Future<List<CalendarNews>> findByMonth(int month, int year,int staffId, int status,int suDung) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findallbymonth?m=${month}&y=${year}&uid=${staffId}&st=${status}&sd=${suDung}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarNews.fromJson(e)).toList();

  }
  Future<CalendarNews> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return CalendarNews.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<List<CalendarNewsLog>> findByLogId(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findbylog/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => CalendarNewsLog.fromJson(e)).toList();

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
  Future<CalendarNews> add(DateTime? tuNgay, String tuGio, DateTime? denNgay, String denGio,
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
    return CalendarNews.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<CalendarNews> update(int id, DateTime? tuNgay, String tuGio, DateTime? denNgay, String denGio,
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
    return CalendarNews.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
