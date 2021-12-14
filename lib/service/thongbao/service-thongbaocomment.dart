import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/thongbao/thongbaocomment.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/thongbaocomment';
class ServiceThongBaoComment
{
  Future<List<ThongBaoComment>> getPaging(int id, int staffId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?id=${id}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => ThongBaoComment.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));
  }
}