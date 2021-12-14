import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vanbandi/vanbandi.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/vanbandi';
class ServiceVanBanDi
{


  Future<List<VanBanDi>> getPaging(int nhomVanBan, String keyword, int maLoaiVB,
      int maLinhVuc,String status, int phoCap, int nguoiNhapId,
  int nguoiChuTriId, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?nvb=${nhomVanBan}&key=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&st=${status}"
        +"&pc=${phoCap}&nid=${nguoiNhapId}&cid=${nguoiChuTriId}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDi.fromJson(e)).toList();

  }
  Future<int> getCount(int nhomVanBan, String keyword, int maLoaiVB,
      int maLinhVuc,String status, int phoCap, int nguoiNhapId,
      int nguoiChuTriId, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?nvb=${nhomVanBan}&keyword=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&st=${status}"
        +"&pc=${phoCap}&nid=${nguoiNhapId}&cid=${nguoiChuTriId}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<List<VanBanDi>> getPagingXuLy(String keyword, int maLoaiVB,
  int maLinhVuc,String status,int phoCap, int nguoiXuLy,int nguoiChuTriId, int xem, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallxlpaging?key=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&st=${status}"
        +"&pc=${phoCap}&nid=${nguoiXuLy}&cid=${nguoiChuTriId}&view=${xem}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDi.fromJson(e)).toList();

  }
  Future<int> getCountXuLy(String keyword, int maLoaiVB,
      int maLinhVuc,String status,int phoCap, int nguoiXuLy,int nguoiChuTriId, int xem, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbyxlkeyword?keyword=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&st=${status}"
        +"&pc=${phoCap}&nid=${nguoiXuLy}&cid=${nguoiChuTriId}&view=${xem}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<VanBanDi>> getPagingSearch(String keyword,String soVanBan,int nhomVanBan, int loaiVanBan,
                                          int maLinhVuc,String status,String nguoiKy, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpagingsearch?key=${keyword}&svb=${soVanBan}&nvb=${nhomVanBan}&mlvb=${loaiVanBan}&mlv=${maLinhVuc}&st=${status}"
        +"&nkyid=${nguoiKy}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDi.fromJson(e)).toList();

  }
  Future<int> getCountSearch(String keyword,String soVanBan,int nhomVanBan, int loaiVanBan,
      int maLinhVuc,String status,String nguoiKy, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbysearch?keyword=${keyword}&svb=${soVanBan}&nvb=${nhomVanBan}&mlvb=${loaiVanBan}&mlv=${maLinhVuc}&st=${status}"
        +"&nkyid=${nguoiKy}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<VanBanDi> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<VanBanDi> updateUserRead(int id, String usersRead
      ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/updateusersread?id=${id}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: usersRead
    );
    return VanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<VanBanDi> changeThoiHan(int id, String thoiHan) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethoihan?id=${id}&thoihan=${thoiHan}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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

  Future<VanBanDi> add(String sid,String soVaoSo, int maNhomVBdi,
      int maLoaiVB,String trichYeu, int maLinhVuc, int maDoMat, int maDoKhan,
      String ngayKy, String ngayVaoSo,
      String ghiChu, int maNguoiKy,
      int nguoiNhapId, int maNguoiChuTri, int maTrangThaiXL
      ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add?sid=${sid}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'soVaoSo': soVaoSo,
          'maNhomVBdi': maNhomVBdi,
          'maLoaiVB': maLoaiVB,
          'trichYeu': trichYeu,
          'maLinhVuc': maLinhVuc,
          'maDoMat': maDoMat,
          'maDoKhan': maDoKhan,
          'maNguoiKy': maNguoiKy,
          'ngayKy': ngayKy,
          'ngayVaoSo': ngayVaoSo,
          'ghiChu': ghiChu,
          'nguoiNhapID':nguoiNhapId,
          'maNguoiChuTri': maNguoiChuTri,
          'maTrangThaiXL': maTrangThaiXL
        })
    );
    return VanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<VanBanDi> addXuLy(int id, String uid, int  tuHoanThanh,
      int theoDoiCap2,String thoiHan, int chuTriId, int trangThai, int trangThaiVB,
      int nguoiGiaoId, String butPhe
      ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/addxuly?id=${id}&tht=${tuHoanThanh}&tdc2=${theoDoiCap2}&th=${thoiHan}&ctid=${chuTriId}&tt=${trangThai}&ttvb=${trangThaiVB}&uids=${uid}&ngid=${nguoiGiaoId}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: butPhe
    );
    return VanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<VanBanDi> update(int id,String sid, String soVaoSo, int maNhomVBdi,
      int maLoaiVB,String trichYeu, int maLinhVuc, int maDoMat, int maDoKhan,
       String ngayKy, String ngayVaoSo,
      String ghiChu, int maNguoiKy,
      int nguoiNhapId, int maNguoiChuTri, int maTrangThaiXL) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update?sid=${sid}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'soVaoSo': soVaoSo,
          'maNhomVBdi': maNhomVBdi,
          'maLoaiVB': maLoaiVB,
          'trichYeu': trichYeu,
          'maLinhVuc': maLinhVuc,
          'maDoMat': maDoMat,
          'maDoKhan': maDoKhan,
          'maNguoiKy': maNguoiKy,
          'ngayKy': ngayKy,
          'ngayVaoSo': ngayVaoSo,
          'ghiChu': ghiChu,
          'nguoiNhapID':nguoiNhapId,
          'maNguoiChuTri': maNguoiChuTri,
          'maTrangThaiXL': maTrangThaiXL
        })
    );
    return VanBanDi.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
