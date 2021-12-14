import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/linhvucvanban.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/danhmuc/linhvucvanban';
class ServiceLinhVucVanBan
{
  Future<List<LinhVucVanBan>> getAllLinhVucVanBan() async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getall"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => LinhVucVanBan.fromJson(e)).toList();


  }
  Future<LinhVucVanBan> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      return LinhVucVanBan.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<List<LinhVucVanBan>> getPaging(String key, int page, int size) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${key}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => LinhVucVanBan.fromJson(e)).toList();


  }

}
