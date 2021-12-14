import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/staffs/sessiontoken.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api';
class ServiceLogin
{
  Future<SessionToken> checkLogin(String userName,String password ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/login"),
        headers: {
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'userName': userName,
          'password': password
        })
    );
    return SessionToken.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}