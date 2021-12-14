import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/hoso/hosocomment.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/hosocomment';
class ServiceHoSoComment
{
  Future<List<HoSoComment>> getPaging(int id, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?id=${id}&uid=-1&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => HoSoComment.fromJson(e)).toList();

  }
}