import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/calendar/data-week.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/week';
class ServiceDataWeek {
  Future<List<DataWeek>> getAllByYear(int year) async {
    final response = await http.get(
      Uri.parse(apiUrl +"/getallbyyear/${year}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DataWeek.fromJson(e)).toList();
  }
  Future<int> getCurrentWeek() async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcurrentweek"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
}