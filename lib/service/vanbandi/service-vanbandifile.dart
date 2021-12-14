import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vanbanden/vanbandenfile.dart';
import 'package:egovapp/model/vanbandi/vanbandifile.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/vanbandifile';
class ServiceVanBanDiFile
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
  Future<List<VanBanDiFile>> getAllByVanBanId(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbyvanbanid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDiFile.fromJson(e)).toList();

  }
  Future<int> chuyenTrinh(int id, int vanBanId, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chuyenfiletrinh?id=${id}&vbid=${vanBanId}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
}
