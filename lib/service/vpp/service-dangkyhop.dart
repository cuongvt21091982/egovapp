import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vpp/dangky.dart';
import 'package:egovapp/model/vpp/dangkyhop.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/vpp/dangkyhop';
class ServiceDangKyHop
{


  Future<List<DangKyHop>> getPagingPheDuyet(String keyword,int phongId, int trangThai, int staffId,int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpheduyetpaging?key=${keyword}&pid=${phongId}&st=${trangThai}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DangKyHop.fromJson(e)).toList();

  }
  Future<List<DangKyHop>> getPaging(String keyword,int phongId, int trangThai, int staffId,int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&pid=${phongId}&st=${trangThai}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DangKyHop.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,int phongId, int trangThai, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&pid=${phongId}&st=${trangThai}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> getCountPheDuyet(String keyword,int phongId, int trangThai, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbypheduyet?keyword=${keyword}&pid=${phongId}&st=${trangThai}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<DangKyHop> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return DangKyHop.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<DangKyHop> add(String ngay, String ghiChu, int phongId, String noiDung,
      String thoiGian, String yeuCauTraLoi, String nguoiChuTri, int nguoiDangKyID, int trangThai) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'dangKyId': 0,
          'ngay': ngay,
          'ghiChu': ghiChu,
          'phongID': phongId,
          'noiDung': noiDung,
          'thoiGian': thoiGian,
          'yeuCauTraLoi': yeuCauTraLoi,
          'nguoiChuTri': nguoiChuTri,
          'nguoiDangKyID': nguoiDangKyID,
          'trangThai': trangThai
        })
    );
    return DangKyHop.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<DangKyHop> update(int id,String ngay, String ghiChu, int phongId, String noiDung,
      String thoiGian, String yeuCauTraLoi, String nguoiChuTri, int nguoiDangKyID, int trangThai ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'dangKyId': id,
          'ngay': ngay,
          'ghiChu': ghiChu,
          'phongID': phongId,
          'noiDung': noiDung,
          'thoiGian': thoiGian,
          'yeuCauTraLoi': yeuCauTraLoi,
          'nguoiChuTri': nguoiChuTri,
          'nguoiDangKyID': nguoiDangKyID,
          'trangThai': trangThai
        })
    );
    return DangKyHop.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<DangKyHop> approved(int id,String ngay, String ghiChu, int phongId, String noiDung,
      String thoiGian, String pheDuyet, String nguoiChuTri, int nguoiDangKyID, int trangThai ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/approved"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'dangKyId': id,
          'ngay': ngay,
          'ghiChu': ghiChu,
          'phongID': phongId,
          'noiDung': noiDung,
          'thoiGian': thoiGian,
          'pheDuyet': pheDuyet,
          'nguoiChuTri': nguoiChuTri,
          'nguoiDangKyID': nguoiDangKyID,
          'trangThai': trangThai
        })
    );
    return DangKyHop.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
