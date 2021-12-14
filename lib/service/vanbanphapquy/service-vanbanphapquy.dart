import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vanbanphapquy/vanbanphapquy.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/vanbanphapquy';
class ServiceVanBanPhapQuy
{


  Future<List<VanBanPhapQuy>> getPaging(String soHieuGoc,String trichYeu,String noiGui, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?sohieugoc=${soHieuGoc}&trichyeu=${trichYeu}&noigui=${noiGui}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanPhapQuy.fromJson(e)).toList();

  }
  Future<int> getCount(String soHieuGoc,String trichYeu,String noiGui) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?sohieugoc=${soHieuGoc}&trichyeu=${trichYeu}&noigui=${noiGui}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<VanBanPhapQuy> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanPhapQuy.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<VanBanPhapQuy> add(String soHieuGoc, String ngayKy, String trichYeu, String noiGui ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'soHieuGoc': soHieuGoc,
          'ngayKy': ngayKy,
          'trichYeu': trichYeu,
          'noiGui': noiGui
        })
    );
    return VanBanPhapQuy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<VanBanPhapQuy> update(int id,String soHieuGoc, String ngayKy, String trichYeu, String noiGui ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'soHieuGoc': soHieuGoc,
          'ngayKy': ngayKy,
          'trichYeu': trichYeu,
          'noiGui': noiGui
        })
    );
    return VanBanPhapQuy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
