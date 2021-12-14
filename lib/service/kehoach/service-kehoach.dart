import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/kehoach/kehoach.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/kehoach';
class ServiceKeHoach
{


  Future<List<KeHoach>> getPaging(String keyword,int loaiKeHoach,int staffId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&loaikh=${loaiKeHoach}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => KeHoach.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,int loaiKeHoach,int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&loaikh=${loaiKeHoach}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<KeHoach> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return KeHoach.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<KeHoach> add(String staffs, int loaiKH, String tenKH, String noiDung,
                      String ghiChu,int nguoiNhap ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add?staffs=${staffs}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'loaiKH': loaiKH,
          'tenKH': tenKH,
          'noiDungKH': noiDung,
          'ghiChu': ghiChu,
          'nguoiNhap': nguoiNhap

        })
    );
    return KeHoach.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<KeHoach> update(int id, String staffs, int loaiKH, String tenKH, String noiDung,
      String ghiChu,int nguoiNhap ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update?staffs=${staffs}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'loaiKH': loaiKH,
          'tenKH': tenKH,
          'noiDungKH': noiDung,
          'ghiChu': ghiChu,
          'nguoiNhap': nguoiNhap

        })
    );
    return KeHoach.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
