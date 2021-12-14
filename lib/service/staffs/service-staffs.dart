import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/staff/staffs';
class ServiceStaffs
{
  Future<List<Staff>> getAllStaffs() async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getall"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => Staff.fromJson(e)).toList();
    }else
      throw Exception(Language.getText('error_access_api'));

  }
  Future<Staff> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );

      return Staff.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<List<Staff>> getPaging(String key, String donViId, int page, int size) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${key}&cvid=-1&dvid=${donViId}&sd=1&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => Staff.fromJson(e)).toList();

  }
  Future<List<Staff>> getAllByWorkGroupId(String groupId) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallbyworkgroupid?id=${groupId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => Staff.fromJson(e)).toList();

  }
  Future<List<Staff>> findAllByStaffId(String sid) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallbystaffids?sid=${sid}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => Staff.fromJson(e)).toList();

  }
  Future<Staff> changeAvatar(int id, String avatar) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/changeavatar/${id}?avatar=${avatar}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Staff.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Message> updateToken(int id,String token) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/updatetoken?id=${id}&token=${token}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Staff> update(int id, String hoDem, String ten, String biDanh,
      String mobile,String ngaySinh,int gioiTinh, String telOffice, String telHome,String email,String address, ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/updatemobile?"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'hoDem': hoDem,
          'ten': ten,
          'biDanh': biDanh,
          'mobile': mobile,
          'ngaySinh': ngaySinh,
          'gioiTinh': gioiTinh,
          'telOffice': telOffice,
          'telHome': telHome,
          'email': email,
          'address': address
        })
    );
    return Staff.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
