import 'dart:convert';
import 'dart:io';

import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/staffs/workgroup.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/staff/workgroups';
class ServiceWorkGroup
{
  Future<List<WorkGroup>> getAllWorkGroup(int staffId) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/findbykeyword?keyword=&sid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => WorkGroup.fromJson(e)).toList();


  }
}