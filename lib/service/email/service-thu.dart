import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/email/thu.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/email/thu';
class ServiceThu
{
  Future<List<Thu>> getPaging(String keyword, int staffId, int read, int del,String status, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&uid=${staffId}&rd=${read}&del=${del}&st=${status}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => Thu.fromJson(e)).toList();

  }

  Future<int> getCount(String keyword, int staffId, int read, int del,String status) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&uid=${staffId}&rd=${read}&del=${del}&st=${status}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<Thu> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Thu.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }

  Future<Thu> getByReadId(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyreadid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Thu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Thu> replyMail(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/replybymail?drid=${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Thu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Thu> addByDraftId(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/addbydraft?drid=${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Thu.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Message> deleteAllByNguoiNhan(int id,int suDung,int suDungNew) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/deleteallbynguoinhan?id=${id}&sd=${suDung}&sdn=${suDungNew}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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
  Future<Message> deleteAllByIds(String id, int suDung, int suDungNew) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/deleteallbyids?id=${id}&sd=${suDung}&sdn=${suDungNew}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Message> ghimMail(int id, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/ghim/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Message> readAllByIds(String id, int read, int readNew) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/readallbyids?id=${id}&rd=${read}&rdn=${readNew}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Message> unGhimMail(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/unghim/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<List<Thu>> getAllByNhomThu(int nhomThu, int staffId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallnhomthu?nid=${nhomThu}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => Thu.fromJson(e)).toList();

  }
  Future<int> chuyenTrinh(int id, int thuId, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chuyentrinh?id=${id}&tid=${thuId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
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
  Future<int> chuyenGiaoViec(int id, int thuId, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chuyengiaoviec?id=${id}&tid=${thuId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
}
