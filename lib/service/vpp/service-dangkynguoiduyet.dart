import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vpp/dangky.dart';
import 'package:egovapp/model/vpp/dangkyhop.dart';
import 'package:egovapp/model/vpp/dangkynguoiduyet.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/vpp/dangkynguoiduyet';
class ServiceDangKyNguoiDuyet
{


  Future<List<DangKyNguoiDuyet>> findAllByDangKyId(int dangKyId,int typeDK) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbydangkyid?dkid=${dangKyId}&ty=${typeDK}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DangKyNguoiDuyet.fromJson(e)).toList();

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
  Future<Message> addMulti(int dangKyId, String staffsId, int type) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/addmulti?dkid=${dangKyId}&stid=${staffsId}&ty=${type}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<DangKyNguoiDuyet> approved(int dangKyId, int staffId, String noiDung,
      int status, int typeDK) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/approved"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'dangKyId': dangKyId,
          'staffId': staffId,
          'noiDung': noiDung,
          'status': status,
          'typeDK': typeDK
        })
    );
    return DangKyNguoiDuyet.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
