import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/totrinh/totrinhxuly.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/totrinhxuly';
class ServiceToTrinhXuLy {
  Future<List<ToTrinhXuLy>> getPaging(String keyword,String status,int staffId,int xem, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => ToTrinhXuLy.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword,String status,int staffId,int xem, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&status=${status}&staffid=${staffId}&xem=${xem}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<ToTrinhXuLy>> getAllByMaYeuCau(int maYeuCau) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/findallbymayeucau/${maYeuCau}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
        var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
        return responseJson.map((e) => ToTrinhXuLy.fromJson(e)).toList();
  }
  Future<int> updateXuLy(int id,String traLoi,int trangThai,int staffId) async{
    final response = await http.post(
      Uri.parse(apiUrl+"/updatexuly"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
        "Content-Type": ApiUtils().contentType,
      },
        body: jsonEncode({
        'id': id,
        'traLoi': traLoi,
        'trangThai': trangThai,
        'staffId': staffId
    })
    );
      return json.decode(response.body) as int;
  }
  Future<Message> chenHoSo(int id, int hoSoId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/chenhoso?id=${id}&hsid=${hoSoId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<int> xuLyLai(int id, int status, int nguoiChuTriId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/xulylai?id=${id}&st=${status}&uid=${nguoiChuTriId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> changeView(int id, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changeview/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<int> changeStatus(int id, int status, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changestatus/${id}?st=${status}&uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<ToTrinhXuLy> getByMaVBAndMaXL(int id, int staffId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getbymavbandmaxl/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return ToTrinhXuLy.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
}