import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vpp/dangky.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/vpp/dangky';
class ServiceDangKy
{


  Future<List<DangKy>> getPagingPheDuyet(String keyword,int thietBiId, int trangThai, int staffId,int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpheduyetpaging?key=${keyword}&tbid=${thietBiId}&st=${trangThai}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DangKy.fromJson(e)).toList();

  }
  Future<List<DangKy>> getPaging(String keyword,int thietBiId, int trangThai, int staffId,int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&tbid=${thietBiId}&st=${trangThai}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DangKy.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,int thietBiId, int trangThai, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&tbid=${thietBiId}&st=${trangThai}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> getCountPheDuyet(String keyword,int thietBiId, int trangThai, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbypheduyet?keyword=${keyword}&tbid=${thietBiId}&st=${trangThai}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<DangKy> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return DangKy.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<DangKy> add(String ngay, String ghiChu, int thietBiId, String noiDung,
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
          'phongID': thietBiId,
          'noiDung': noiDung,
          'thoiGian': thoiGian,
          'yeuCauTraLoi': yeuCauTraLoi,
          'nguoiChuTri': nguoiChuTri,
          'nguoiDangKyID': nguoiDangKyID,
          'trangThai': trangThai
        })
    );
    return DangKy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<DangKy> update(int id,String ngay, String ghiChu, int thietBiId, String noiDung,
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
          'phongID': thietBiId,
          'noiDung': noiDung,
          'thoiGian': thoiGian,
          'yeuCauTraLoi': yeuCauTraLoi,
          'nguoiChuTri': nguoiChuTri,
          'nguoiDangKyID': nguoiDangKyID,
          'trangThai': trangThai
        })
    );
    return DangKy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<DangKy> approved(int id,String ngay, String ghiChu, int thietBiId, String noiDung,
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
          'phongID': thietBiId,
          'noiDung': noiDung,
          'thoiGian': thoiGian,
          'pheDuyet': pheDuyet,
          'nguoiChuTri': nguoiChuTri,
          'nguoiDangKyID': nguoiDangKyID,
          'trangThai': trangThai
        })
    );
    return DangKy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
