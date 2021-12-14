import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/danhmuc/loaiphong.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/danhmuc/loaiphong';
class ServiceLoaiPhong
{
  Future<List<LoaiPhong>> getAllLoaiPhong() async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getall"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => LoaiPhong.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));

  }
  Future<LoaiPhong> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200)
      return LoaiPhong.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    else
      throw Exception(Language.getText('error_access_api'));
  }
  Future<List<LoaiPhong>> getPaging(String key, int page, int size) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${key}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => LoaiPhong.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));

  }

}
