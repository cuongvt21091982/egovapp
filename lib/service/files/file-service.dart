import 'dart:async';
import 'dart:convert';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/file/fileitem.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/avatar';
class FileService
{
  Future<FileItem> upload(String filePath) async {
    Map<String, String> headers = { "Authorization": ApiUtils.token};
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl+"/upload")
    );
    request.headers.addAll(headers);
    request.files.add(
        await http.MultipartFile.fromPath("fileItem",filePath )
    );
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return FileItem.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

}
