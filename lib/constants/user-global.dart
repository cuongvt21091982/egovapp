import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/model/staffs/sessiontoken.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/service/staffs/service-login.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthSession
{
  static int staffId = 268;
  static int userId =6;
  static int unitId =95;
  static String userName="";
  static String fullName="";
  static String unitName="";
  static String chucVuName="";
  static String pathAvatar="";

  static Future<String> getAvatar() async
  {
      String path = ApiUtils().avatarDefault;
      final Staff staff= await ServiceStaffs().getById(staffId).catchError((onError)
      {

      });
      path=  staff.anh.isNotEmpty? staff.anh: path;
         return  ApiUtils().getUrlAvatar(path);
  }
  static void getAccount()
  {
    ServiceStaffs().getById(UserAuthSession.staffId).then((value) {
      String path = ApiUtils().avatarDefault;
        path=  value.anh.isNotEmpty? value.anh: path;
        pathAvatar=  ApiUtils().getUrlAvatar(path);
        fullName=value.fullName;
        chucVuName=value.chucVuItem.tenChucVu;
        unitName=value.donViItem.tenCQ;

    }).catchError((onError)
    {
      pathAvatar=ApiUtils().getDefaultUrlAvatar();
    });
  }
  static Future<bool> checkLogin(String userName,String password)async
  {
       final SessionToken sessionToken= await ServiceLogin().checkLogin(userName, password)
           .catchError((onError){
       });
       if(sessionToken.userId!=0 && sessionToken.token.isNotEmpty)
         {
          ApiUtils.token= "Bearer ${sessionToken.token}";
           UserAuthSession.unitId=sessionToken.maDonVi;
           UserAuthSession.staffId=sessionToken.staffId;
           UserAuthSession.userId=sessionToken.userId;
           UserAuthSession.userName=userName;
           SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
           sharedPreferences.setString("userName", userName);
           sharedPreferences.setString("password", password);
           sharedPreferences.setString("token", sessionToken.token);
           sharedPreferences.setString("userId", UserAuthSession.userId.toString());
           sharedPreferences.setString("staffId", UserAuthSession.staffId.toString());
           sharedPreferences.setString("maDonVi", UserAuthSession.unitId.toString());
           return true;
         }else
           return false;
  }
}

