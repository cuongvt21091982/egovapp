import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/thongbao/thongbaofilexuly.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/thongbaofilexuly';
class ServiceThongBaoFileXL
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
  Future<List<ThongBaoFileXuLy>> getAllByThongBaoId(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbythongbaoid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );

    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => ThongBaoFileXuLy.fromJson(e)).toList();

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

}
