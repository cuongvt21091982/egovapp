import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/staffs/navitem.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/staff/navitem';
class ServiceNavItem
{
  Future<List<NavItem>> findALlByStaffId(int staffId, int type, bool active) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbytypeandactive?stid=${staffId}&type=${type}&active=${active}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
      return responseJson.map((e) => NavItem.fromJson(e)).toList();
  }
  Future<int> checkPermissionByCode(int staffId,String code, bool active) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/checkpermissionbycode?stid=${staffId}&cd=${code}&active=${active}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

}
