import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/email/documentdraft.dart';
import 'package:egovapp/model/hoso/hoso.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/draft/documentdraft';
class ServiceDocumentDraft
{


  Future<List<DocumentDraft>> getPaging(String keyword,String type,int staffId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&ty=${type}&uid=${staffId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => DocumentDraft.fromJson(e)).toList();

  }

  Future<int> getCount(String keyword,String type,int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&ty=${type}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<DocumentDraft> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return DocumentDraft.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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
  Future<DocumentDraft> add(String chuDe, int beLongTo, String noiDung, String docType,
      String lstReceiveUsers, int replyId, int sendMail) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'chuDe': chuDe,
          'beLongToID': beLongTo,
          'noiDung': noiDung,
          'docType': docType,
          'lstReceiveUsers': lstReceiveUsers,
          'replyId':replyId,
          'sendMail':sendMail
        })
    );
    return DocumentDraft.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<HoSo> update(int id,String chuDe, int beLongTo, String noiDung, String docType,
      String lstReceiveUsers, int replyId, int sendMail ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'chuDe': chuDe,
          'beLongToID': beLongTo,
          'noiDung': noiDung,
          'docType': docType,
          'lstReceiveUsers': lstReceiveUsers,
          'replyId':replyId,
          'sendMail':sendMail
        })
    );
    return HoSo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
