import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/totrinh/totrinhfile.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/totrinhfile';
class ServiceToTrinhFile
{

  Future<http.StreamedResponse> add(int id, String filePath) async {
    Map<String, String> headers = { "Authorization": ApiUtils.token};
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl+"/add?id="+id.toString())
      );
    request.headers.addAll(headers);
    request.files.add(
        await http.MultipartFile.fromPath("UploadFiles",filePath )
    );
    var res = await request.send();
    return res;
  }
  Future<Message> delete(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/delete/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return  Message.fromJson( json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<List<ToTrinhFile>> getAllByToTrinhId(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbytotrinhid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => ToTrinhFile.fromJson(e)).toList();

  }

}
