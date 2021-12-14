import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/meeting/meeting.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/meeting';
class ServiceMeeting
{


  Future<List<Meeting>> getPaging(String keyword,String status, int staffId, int xem, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => Meeting.fromJson(e)).toList();

  }

  Future<int> getCount(String keyword,String status, int staffId, int xem) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&staffid=${staffId}&status=${status}&xem=${xem}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<Meeting> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Meeting.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<Meeting> changeThamKhao(int id, int status) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethamkhao?id=${id}&st=${status}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Meeting.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<Meeting> changeThoiHan(int id, String thoiHan) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethoihan?id=${id}&thoihan=${thoiHan}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Meeting.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<Meeting> resetMeeting(int id, int status) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/reset?id=${id}&st=${status}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Meeting.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<int> joinMeeting(int id, String staffs) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/joinmeeting?id=${id}&users=${staffs}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
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
  Future<Meeting> add(String staffs, String chuDe, String thoiGianHoanThanh, int choThamKhao,
      String noiDung,int trangThai,int maNguoiChuTri ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add?users=${staffs}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'chuDe': chuDe,
          'thoiGianHoanThanh': thoiGianHoanThanh,
          'choThamKhao': choThamKhao,
          'noiDung': noiDung,
          'trangThai': trangThai,
          'maNguoiChuTri': maNguoiChuTri
        })
    );
    return Meeting.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<Meeting> update(String staffs, int id, String chuDe, String thoiGianHoanThanh, int choThamKhao,
      String noiDung,int trangThai,int maNguoiChuTri ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update?users=${staffs}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'chuDe': chuDe,
          'thoiGianHoanThanh': thoiGianHoanThanh,
          'choThamKhao': choThamKhao,
          'noiDung': noiDung,
          'trangThai': trangThai,
          'maNguoiChuTri': maNguoiChuTri
        })
    );
    return Meeting.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

}
