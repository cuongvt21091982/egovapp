import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/meeting/meetingxuly.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/meetingxuly';
class ServiceMeetingXuLy
{


  Future<List<MeetingXuLy>> getPaging(String keyword, String status, int staffId, int xem,
       int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => MeetingXuLy.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword, String status, int staffId, int xem) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<int> xuLyLai(int id, int status, int nguoiChuTriId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/xulylai?id=${id}&st=${status}&uid=${nguoiChuTriId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<int> changeStatus(int id, int status, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changestatus/${id}?st=${status}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> changeView(int id, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changeview/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<MeetingXuLy> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return MeetingXuLy.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<MeetingXuLy> getByMaVBAndMaXL(int id, int staffId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getbymavbandmaxl/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return MeetingXuLy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<List<MeetingXuLy>> getAllByMaYeuCau(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findallbymayeucau/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => MeetingXuLy.fromJson(e)).toList();
  }
}
