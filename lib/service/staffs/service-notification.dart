import 'dart:convert';
import 'dart:io';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/staffs/confignotification.dart';
import 'package:egovapp/model/staffs/notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
final String apiUrl = ApiUtils().apiUrl+'/api/notification';
class ServiceNotification
{
  Future<ConfigNotification> getConfig() async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getconfig"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
      return ConfigNotification.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<NotificationItem> getByMessageId(String messageId) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getbymessageid?id=${messageId}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return NotificationItem.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<NotificationItem> updateStatus(int id) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/updatestatus?id=${id}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return NotificationItem.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  Future<int> getCount(int staffId, int status,String type) async{
    final response = await http.get(
      Uri.parse(apiUrl+"/getcount?sid=${staffId}&st=${status}&ty=${type}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    return json.decode(response.body) as int;
  }
  Future<List<NotificationItem>> getPaging(int staffId, int status,String type, int page, int size) async {

    final response = await http.get(
      Uri.parse(apiUrl+"/getallpaging?sid=${staffId}&st=${status}&ty=${type}&page=${page}&size=${size}"),
      headers: {
        HttpHeaders.authorizationHeader: ApiUtils.token,
      },
    );
    var responseJson = json.decode(utf8.decode(response.bodyBytes)) as List;
    return responseJson.map((e) => NotificationItem.fromJson(e)).toList();

  }
}