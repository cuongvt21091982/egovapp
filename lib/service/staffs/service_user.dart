import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/staffs/users.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/staff/users';
class ServiceUser
{
  Future<Users> update(int id, String userName, int staffID, String password) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update?"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'userName': userName,
          'staffID': staffID,
          'password': password
        })
    );
    return Users.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}