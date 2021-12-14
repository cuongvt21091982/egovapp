import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/kehoach/kehoachnguoidoc.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/kehoachnguoidoc';
class ServiceKeHoachNguoiDoc
{
  Future<List<KeHoachNguoiDoc>> getAllByKeHoachId(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbykehoachid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );

    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => KeHoachNguoiDoc.fromJson(e)).toList();

  }
  Future<int> addMulti(int id,String sid) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/addmulti/${id}?sid=${sid}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

}
