import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/danhmuc/message.dart';
import 'package:egovapp/model/vanbanden/vanbanden.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/info/vanbanden';
class ServiceVanBanDen
{


  Future<List<VanBanDen>> getPaging(String keyword, int maLoaiVB, int maLinhVuc,
      String status, int phoCap, int nguoiNhapId, int nguoiChuTriId,
      int maNoiGui, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?key=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&status=${status}"
        +"&phocap=${phoCap}&nhapid=${nguoiNhapId}&chutriid=${nguoiChuTriId}&noiguiid=${maNoiGui}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDen.fromJson(e)).toList();

  }
  Future<int> getCount(String keyword, int maLoaiVB, int maLinhVuc,
      String status, int phoCap, int nguoiNhapId, int nguoiChuTriId,
      int maNoiGui, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbykeyword?keyword=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&status=${status}"
        +"&phocap=${phoCap}&nhapid=${nguoiNhapId}&chutriid=${nguoiChuTriId}&noiguiid=${maNoiGui}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }

  Future<List<VanBanDen>> getPagingXuLy(String keyword, int maLoaiVB, int maLinhVuc,
      String status, int phoCap, int nguoiXuLy, int nguoiChuTriId,
      int maNoiGui, int xem, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallxlpaging?key=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&st=${status}"
        +"&pc=${phoCap}&xlid=${nguoiXuLy}&cid=${nguoiChuTriId}&ngid=${maNoiGui}&xe=${xem}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDen.fromJson(e)).toList();

  }
  Future<int> getCountXuLy(String keyword, int maLoaiVB, int maLinhVuc,
      String status, int phoCap, int nguoiXuLy, int nguoiChuTriId,
      int maNoiGui, int xem, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbyxlkeyword?keyword=${keyword}&mlvb=${maLoaiVB}&mlv=${maLinhVuc}&st=${status}"
        +"&pc=${phoCap}&xlid=${nguoiXuLy}&cid=${nguoiChuTriId}&ngid=${maNoiGui}&xe=${xem}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<VanBanDen>> getPagingSearch(String keyword, String soVanBan, int maLoaiVanBan, int maLinhVuc,
      String status, int phoCap, int nguoiXuLy, int nguoiChuTriId,
      int maNoiGui, int xem, String fromDate, String toDate, int page, int size) async {
    final response = await http.get(
      Uri.parse(apiUrl+"/getallpagingsearch?key=${keyword}&svb=${soVanBan}&mlvb=${maLoaiVanBan}&mlv=${maLinhVuc}&status=${status}"
        +"&ngid=${maNoiGui}&frdate=${fromDate}&todate=${toDate}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => VanBanDen.fromJson(e)).toList();

  }
  Future<int> getCountSearch(String keyword, String soVanBan, int maLoaiVanBan, int maLinhVuc,
      String status, int phoCap, int nguoiXuLy, int nguoiChuTriId,
      int maNoiGui, int xem, String fromDate, String toDate) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcountbysearch?keyword=${keyword}&svb=${soVanBan}&mlvb=${maLoaiVanBan}&mlv=${maLinhVuc}&status=${status}"
        +"&ngid=${maNoiGui}&frdate=${fromDate}&todate=${toDate}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<VanBanDen> getById(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/findbyid/${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanDen.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
  Future<VanBanDen> changeThoiHan(int id, String thoiHan) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/changethoihan?id=${id}&thoihan=${thoiHan}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return VanBanDen.fromJson(json.decode(utf8.decode(response.bodyBytes)));

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

  Future<VanBanDen> add(String soVaoSo, String soHieuGoc,
      int maLoaiVB,String trichYeu, int maLinhVuc, int maDoMat, int maDoKhan,
      String ngayKy, String nguoiKy, String ngayNhan, String ngayVaoSo,
      String ghiChu,
      int maNguoiChuTri, int soVanThuID, int maNoiGui, int maTrangThaiXL, int nguoiNhapId
     ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/add"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': 0,
          'soVaoSo': soVaoSo,
          'soHieuGoc': soHieuGoc,
          'maLoaiVB': maLoaiVB,
          'trichYeu': trichYeu,
          'maLinhVuc': maLinhVuc,
          'maDoMat': maDoMat,
          'maDoKhan': maDoKhan,
          'ngayKy': ngayKy,
          'nguoiKy': nguoiKy,
          'ngayNhan': ngayNhan,
          'ngayVaoSo': ngayVaoSo,
          'ghiChu': ghiChu,
          'maNguoiChuTri': maNguoiChuTri,
          'soVanThuID': soVanThuID,
          'maNoiGui': maNoiGui,
          'maTrangThaiXL': maTrangThaiXL,
          'nguoiNhapID': nguoiNhapId
        })
    );
    return VanBanDen.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<VanBanDen> addXuLy(int id, String uid, int  tuHoanThanh,
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
    return VanBanDen.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<VanBanDen> butPhe(int id, int ctid,String butPhe
      ) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/butphe?id=${id}&ctid=${ctid}"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'butPhe': butPhe
        })
    );
    return VanBanDen.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<VanBanDen> update(int id, String soVaoSo, String soHieuGoc,
      int maLoaiVB,String trichYeu, int maLinhVuc, int maDoMat, int maDoKhan,
      String ngayKy, String nguoiKy, String ngayNhan, String ngayVaoSo,
      String ghiChu,
      int maNguoiChuTri, int soVanThuID, int maNoiGui, int maTrangThaiXL, int nguoiNhapId) async{
    final response = await http.post(
        Uri.parse(apiUrl+"/update"),
        headers: {
          HttpHeaders.authorizationHeader: ApiUtils.token,
          "Content-Type": ApiUtils().contentType,
        },
        body: jsonEncode({
          'id': id,
          'soVaoSo': soVaoSo,
          'soHieuGoc': soHieuGoc,
          'maLoaiVB': maLoaiVB,
          'trichYeu': trichYeu,
          'maLinhVuc': maLinhVuc,
          'maDoMat': maDoMat,
          'maDoKhan': maDoKhan,
          'ngayKy': ngayKy,
          'nguoiKy': nguoiKy,
          'ngayNhan': ngayNhan,
          'ngayVaoSo': ngayVaoSo,
          'ghiChu': ghiChu,
          'maNguoiChuTri': maNguoiChuTri,
          'soVanThuID': soVanThuID,
          'maNoiGui': maNoiGui,
          'maTrangThaiXL': maTrangThaiXL,
          'nguoiNhapID': nguoiNhapId
        })
    );
    return VanBanDen.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
}
