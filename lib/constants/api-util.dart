import 'package:egovapp/constants/user-global.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiUtils
{
  //static  String apiUrl = 'http://localhost:8083';
   String apiUrl = 'http://192.168.0.106:8083';
 // String apiUrl = 'http://192.168.1.23:8083';
   String avatarDefault = '/avatar/default';
   static bool changeAvatar=false;
  //static  String apiUrl = 'http://192.168.1.240:8083';

  static String token ='Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2IiwiaWF0IjoxNjM3NzQzMTU0LCJleHAiOjE2MzgzNDc5NTR9.gP0ep47j2XR_HApr1_FRodY9zYgLH0Eg-bbO2rFZrMw';
    String downloadUrl = '/document/downloadfile?';
    String contentType = 'application/json';
   Map<String, String> get headers => {
    "Authorization": "Bearer $token",
  };

   String  getDownloadFileUrl(String folder, String fileKey, String type, String title)
  {
    return '${apiUrl}${downloadUrl}file=${folder}${fileKey}&type=${type}&title=${title}&auth=$token';
      //'${apiUrl}${downloadUrl}file=${folder}${fileKey}&type=${type}&title=${title}';
  }
   String getUrlAvatar(String path)
  {
    return '${apiUrl}${downloadUrl}file=${path}&type=image/jpg&title=avatar&auth=$token';
  }
   String getDefaultUrlAvatar()
  {
    return '${apiUrl}${downloadUrl}file=${avatarDefault}&type=image/jpg&title=avatar&auth=$token';
  }
  Future<bool> getToken() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.get("userName")!=null)
      {
        bool check=await UserAuthSession.checkLogin(sharedPreferences.get("userName").toString(), sharedPreferences.get("password").toString()) ;
        return check;
      }else
        return false;
  }
}
