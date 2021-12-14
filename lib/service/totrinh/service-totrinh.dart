import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/totrinh';
class ServiceToTrinh
{


  Future<List<ToTrinh>> getPaging(String keyword,String status,int staffId,int xem, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => ToTrinh.fromJson(e)).toList();

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
  Future<int> chuyenTrinh(int id,int toTrinhId,int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chuyentrinh?id=${id}&ttid=${toTrinhId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> chuyenGiaoViec(int id,int toTrinhId,int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chuyengiaoviec?id=${id}&ttid=${toTrinhId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> chenHoSo(int id,int hoSoId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chenhoso?id=${id}&hsid=${hoSoId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<ToTrinh> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      return ToTrinh.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<ToTrinh> changeThoiHan(int id, String thoiHan) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethoihan?id=${id}&thoihan=${thoiHan}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return ToTrinh.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<int> joinToTrinh(int id,String staffs) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/jointotrinh?id=${id}&users=${staffs}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
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
  Future<ToTrinh> add(String users, String chuDe, String noiDung, int maNguoiChuTri,String thoiHan,int trangThai ) async{
    final response = await http.post(
      Uri.parse(apiUrl+"/add?users=${users}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
        "Content-Type": ApiUtils().contentType,
      },
      body: jsonEncode({
        'chuDe': chuDe,
        'noiDung': noiDung,
        'maNguoiChuTri': maNguoiChuTri,
        'thoiGianHoanThanh': thoiHan,
        'trangThai': trangThai
      })
    );
      return ToTrinh.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<ToTrinh> update(String users, int id, String chuDe, String noiDung, int maNguoiChuTri,String thoiHan,int trangThai ) async{
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
          'maNguoiChuTri': maNguoiChuTri,
          'thoiGianHoanThanh': thoiHan,
          'trangThai': trangThai
        })
    );
    return ToTrinh.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
