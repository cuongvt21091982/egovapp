import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/vanbandi/nhomvanbandi.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/nhomvanbandi';
class ServiceNhomVanBanDi
{
  Future<List<NhomVanBanDi>> getAllNhomVanBanDi() async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getall"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => NhomVanBanDi.fromJson(e)).toList();


  }
  Future<NhomVanBanDi> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      return NhomVanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<List<NhomVanBanDi>> getPaging(String key) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/findbykeyword?keyword=${key}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );

      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => NhomVanBanDi.fromJson(e)).toList();


  }

}
