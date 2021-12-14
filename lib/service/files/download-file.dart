
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class DownloadFile
{
   Future<File> download(String url, String filename) async {
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
   Future downloadFile(String url,String savePath) async {
     try {
       Dio dio = Dio();

       String fileName ="vanban.pdf";// url.substring(url.lastIndexOf("/") + 1);
       savePath = await getFilePath(fileName);
       await dio.download(url, savePath, onReceiveProgress: (rec, total) {
       } );

     } catch (e) {
       print(e.toString());
     }
   }
   Future<String> getFilePath(uniqueFileName) async {
     String path = '';

     //Directory dir = await getApplicationDocumentsDirectory();

     path = 'D:/mobile/$uniqueFileName';

     return path;
   }

}
