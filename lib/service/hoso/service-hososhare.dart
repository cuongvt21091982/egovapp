import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/hoso/hosocomment.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/hososhare';
class ServiceHoSoShare
{
  Future<Message> addShare(int hoSoId,int staffId,String staffs, String comment) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/addshare?hsid=${hoSoId}&uid=${staffId}&sid=${staffs}&cm=${comment}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<Message> updateShare(int hoSoId,int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/updateshare?hsid=${hoSoId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}