import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/thongbao';
class ServiceThongBao
{


  Future<List<ThongBao>> getPaging(String keyword,int staffId, int nguoiNhapId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&uid=${staffId}&nid=${nguoiNhapId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => ThongBao.fromJson(e)).toList();

  }
  Future<List<ThongBao>> getPagingByQL(String keyword,int nguoiNhapId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallqlpaging?key=${keyword}&nid=${nguoiNhapId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => ThongBao.fromJson(e)).toList();

  }
  Future<List<ThongBao>> getAllByAlert(int staffId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findallbyalert?id=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => ThongBao.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,int staffId, int nguoiNhapId,) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&uid=${staffId}&nid=${nguoiNhapId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> getCountQL(String keyword,int nguoiNhapId,) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbyqlkeyword?keyword=${keyword}&nid=${nguoiNhapId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<ThongBao> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return ThongBao.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<ThongBao> getByReadId(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyreadid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return ThongBao.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<ThongBao> add(String staffs, String chuDe, String ngayHieuLuc, String noiDung,
      String ngayHetHieuLuc,int nguoiNhap ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add?staffs=${staffs}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'chuDe': chuDe,
          'ngayHieuLuc': ngayHieuLuc,
          'noiDung': noiDung,
          'ngayHetHieuLuc': ngayHetHieuLuc,
          'nguoiNhap': nguoiNhap

        })
    );
    return ThongBao.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<ThongBao> update(String staffs, int id, String chuDe, String ngayHieuLuc, String noiDung,
      String ngayHetHieuLuc,int nguoiNhap ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update?staffs=${staffs}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'chuDe': chuDe,
          'ngayHieuLuc': ngayHieuLuc,
          'noiDung': noiDung,
          'ngayHetHieuLuc': ngayHetHieuLuc,
          'nguoiNhap': nguoiNhap
        })
    );
    return ThongBao.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<int> updateXuLy(int id, String traLoi, int trangThai, int staffId, int replyId) async{
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
          'staffId': staffId,
          'replyId':replyId
        })
    );
    return json.decode(response.body) as int;
  }
}
