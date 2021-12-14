import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vanbanden/vanbanden.dart';
import 'package:egovapp/model/vanbanden/vanbandenxuly.dart';
import 'package:egovapp/model/vanbandi/vanbandixuly.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/vanbandixl';
class ServiceVanBanDiXuLy
{


  Future<List<VanBanDiXuLy>> getPaging(String keyword, String status, int phoCap, int maNguoiXuLy,
      int nguoiChuTriId, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&st=${status}"
          +"&pc=${phoCap}&nid=${maNguoiXuLy}&cid=${nguoiChuTriId}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDiXuLy.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword, String status, int phoCap, int maNguoiXuLy,
      int nguoiChuTriId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&st=${status}"
          +"&pc=${phoCap}&nid=${maNguoiXuLy}&cid=${nguoiChuTriId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
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
  Future<int> giaoThem(int id, String uids) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/giaothem?id=${id}&uids=${uids}"),
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
  Future<int> changeView(int id, int staffId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changeview/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<VanBanDenXuLy> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanDenXuLy.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }

  Future<Message> delete(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/delete/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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
  Future<Message> changePhoCap(int id, int phoCap) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changephocap?id=${id}&pc=${phoCap}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return Message.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<VanBanDiXuLy> addXuLy(int id, String uid, int  tuHoanThanh,
      int theoDoiCap2,String thoiHan, int chuTriId, int trangThai,
      int nguoiChutri, String butPhe
      ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/addxuly?id=${id}&tht=${tuHoanThanh}&tdc2=${theoDoiCap2}&tt=${trangThai}&uids=${uid}&nct=${nguoiChutri}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: butPhe
    );
    return VanBanDiXuLy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<int> updateXuLy(int id, String traLoi, int trangThai, int staffId) async{
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
  Future<VanBanDiXuLy> getByMaVBAndMaXL(int id, int staffId) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getbymavbandmaxl/${id}?uid=${staffId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanDiXuLy.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<List<VanBanDiXuLy>> getAllByMaVB(int id) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallbymavb/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDiXuLy.fromJson(e)).toList();
  }
}
