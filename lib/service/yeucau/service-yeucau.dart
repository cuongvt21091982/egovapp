import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/yeucau/yeucau.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/yeucau';
class ServiceYeuCau
{


  Future<List<YeuCau>> getPaging(String keyword,String status,int staffId,int xem, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => YeuCau.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,String status,int staffId,int xem, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&staffid=${staffId}&status=${status}&xem=${xem}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<YeuCau> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return YeuCau.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<int> joinYeuCau(int id,String staffs) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/joinyeucau?id=${id}&users=${staffs}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<YeuCau> changeThoiHan(int id, String thoiHan) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethoihan?id=${id}&thoihan=${thoiHan}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return YeuCau.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<YeuCau> changeThamKhao(int id, int status) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethamkhao?id=${id}&st=${status}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return YeuCau.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<Message> chenHoSo(int id, int hoSoId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chenhoso?id=${id}&hsid=${hoSoId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<int> chuyenTrinh(int id, int yeuCauId, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chuyentrinh?id=${id}&ycid=${yeuCauId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<YeuCau> add(String users, String chuDe,
      String noiDung,
      int choThamKhao,
      String thoiGianHoanThanh,
      int maNguoiChuTri,
      int trangThai) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add?users=${users}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'chuDe': chuDe,
          'noiDung': noiDung,
          'thoiGianHoanThanh': thoiGianHoanThanh,
          'choThamKhao': choThamKhao,
          'maNguoiChuTri': maNguoiChuTri,
          'trangThai': trangThai
        })
    );
    return YeuCau.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<YeuCau> update(String users, int id, String chuDe,
      String noiDung,
      int choThamKhao,
      String thoiGianHoanThanh,
      int maNguoiChuTri,
      int trangThai) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update?users=${users}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'chuDe': chuDe,
          'noiDung': noiDung,
          'thoiGianHoanThanh': thoiGianHoanThanh,
          'choThamKhao': choThamKhao,
          'maNguoiChuTri': maNguoiChuTri,
          'trangThai': trangThai
        })
    );
    return YeuCau.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
