import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/sovanthu/sovanthu.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/sovanthu';
class ServiceSoVanThu
{


  Future<List<SoVanThu>> getPaging(String keyword, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => SoVanThu.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<SoVanThu>> getPagingDV(String keyword,int maDonVi,int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getalldonvipaging?key=${keyword}&dvid=${maDonVi}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => SoVanThu.fromJson(e)).toList();

  }
  Future<int> getCountDV(String keyword, int maDonVi) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbydonvi?keyword=${keyword}&dvid=${maDonVi}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<SoVanThu> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return SoVanThu.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
    Future<SoVanThu> getByDonViId(int id) async{
      final response = await http.get(
        Uri.parse(apiUrl+"/findbydvid/${id}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
        },
      );
      return SoVanThu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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
  Future<SoVanThu> add(String tenSoVanThu, String soVaoSo, int suDung, int stt,
      String kyHieuVanBan ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'tenSoVanThu': tenSoVanThu,
          'soVaoSo': soVaoSo,
          'suDung': suDung,
          'stt': stt,
          'kyHieuVanBan': kyHieuVanBan
        })
    );
    return SoVanThu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<SoVanThu> update(int id,String tenSoVanThu, String soVaoSo, int suDung, int stt,
      String kyHieuVanBan ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'tenSoVanThu': tenSoVanThu,
          'soVaoSo': soVaoSo,
          'suDung': suDung,
          'stt': stt,
          'kyHieuVanBan': kyHieuVanBan
        })
    );
    return SoVanThu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
