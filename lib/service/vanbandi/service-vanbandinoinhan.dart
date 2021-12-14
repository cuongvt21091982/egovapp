import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/vanbandi/vanbandinoinhan.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/vanbandinoinhan';
class ServiceVanBanDiNoiNhan
{

  Future<List<VanBanDiNoiNhan>> getAllByVanBanId(int id) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallbymavb/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );

    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDiNoiNhan.fromJson(e)).toList();


  }

}
