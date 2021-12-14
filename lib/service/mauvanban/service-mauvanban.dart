import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/mauvanban/mauvanban.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/mauvanban';
class ServiceMauVanBan
{


  Future<List<MauVanBan>> getPaging(String tenVanBan,String ghiChu,int maLoai, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?tenvanban=${tenVanBan}&ghichu=${ghiChu}&maloai=${maLoai}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => MauVanBan.fromJson(e)).toList();

  }
  Future<int> getCount(String tenVanBan,String ghiChu,int maLoai) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?tenvanban=${tenVanBan}&ghichu=${ghiChu}&maloai=${maLoai}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<MauVanBan> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return MauVanBan.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<MauVanBan> add(String tenVanBan, String ghiChu, int maLoai,
      int nguoiNhapID ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'tenVanBan': tenVanBan,
          'ghiChu': ghiChu,
          'maLoai': maLoai,
          'nguoiNhapID': nguoiNhapID
        })
    );
    return MauVanBan.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<MauVanBan> update(int id,String tenVanBan, String ghiChu, int maLoai,
      int nguoiNhapID ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'tenVanBan': tenVanBan,
          'ghiChu': ghiChu,
          'maLoai': maLoai,
          'nguoiNhapID': nguoiNhapID
        })
    );
    return MauVanBan.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
