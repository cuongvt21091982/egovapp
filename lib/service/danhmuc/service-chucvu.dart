import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/danhmuc/chucvu.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/danhmuc/chucvu';
class ServiceChucVu
{
  Future<List<ChucVu>> getAllChucVu() async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getall"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => ChucVu.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));

  }
  Future<ChucVu> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200)
      return ChucVu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    else
      throw Exception(Language.getText('error_access_api'));
  }
  Future<List<ChucVu>> getPaging(String key, int page, int size) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${key}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => ChucVu.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));

  }

}
