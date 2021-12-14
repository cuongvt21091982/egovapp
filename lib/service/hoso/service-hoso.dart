import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/hoso/hoso.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/hoso';
class ServiceHoSo
{


  Future<List<HoSo>> getPaging(String keyword,String status, int staffId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&st=${status}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => HoSo.fromJson(e)).toList();

  }
  Future<List<HoSo>> getPagingDonVi(String keyword,String status, int staffId, int donViId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getalldonvipaging?key=${keyword}&st=${status}&uid=${staffId}&dvid=${donViId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => HoSo.fromJson(e)).toList();

  }
  Future<List<HoSo>> getAllByShare(String status,int staffId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallshare?st=${status}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => HoSo.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,String status, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&st=${status}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> getCountDonVi(String keyword,String status, int staffId, int donViId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbydonvi?keyword=${keyword}&st=${status}&uid=${staffId}&dvid=${donViId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<HoSo> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return HoSo.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<HoSo> add(String tenHoSo, int beLongTo, String quaTrinhXuLy, int trangThai,
      String ngayTao,String ngayKetThuc ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'tenHoSo': tenHoSo,
          'beLongTo': beLongTo,
          'quaTrinhXuLy': quaTrinhXuLy,
          'trangThai': trangThai,
          'ngayTao': ngayTao,
          'ngayKetThuc': ngayKetThuc
        })
    );
    return HoSo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<HoSo> update(int id,String tenHoSo, int beLongTo, String quaTrinhXuLy, int trangThai,
      String ngayTao,String ngayKetThuc ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'tenHoSo': tenHoSo,
          'beLongTo': beLongTo,
          'quaTrinhXuLy': quaTrinhXuLy,
          'trangThai': trangThai,
          'ngayTao': ngayTao,
          'ngayKetThuc': ngayKetThuc
        })
    );
    return HoSo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<int> updateXuLy(int id, String traLoi, int trangThai, int staffId) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/updatexuly"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'traLoi': traLoi,
          'trangThai': trangThai,
          'staffId': staffId
        })
    );
    return json.decode(response.body) as int;
  }
}
