import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/calendar/calendardepartcomment.dart';
import 'package:egovapp/model/calendar/calendarnewscomment.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/calendarnewscomment';
class ServiceCalendarNewsComment
{
  Future<List<CalendarNewsComment>> getPaging(int id,int maNam,  int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?id=${id}&yid=${maNam}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => CalendarNewsComment.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));
  }
  Future<CalendarNewsComment> add(int week, int year, String comment, int staffId,) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'maXLId': week,
          'maNam': year,
          'comment': comment,
          'staffId': staffId
        })
    );
    return CalendarNewsComment.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}