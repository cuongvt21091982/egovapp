import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatUtils
{
  static DateTime? formatDateYYYYMMDDHHMMSS(String value)
  {
    try {
      return DateTime.parse(value);
    }catch(e)
    {
      return null;
    }
  }
  static DateTime? formatDateVN(String value)
  {
    try {
      List<String>  arr  = value.split('/');
      if(arr.length>=3)
        return DateTime.parse(arr[1]+"/"+arr[0]+"/"+arr[2]);

    }catch(e)
    {
      return null;
    }
  }
  static DateTime convertDateTime(DateTime date, String time)
  {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(date);
      //DateTime dateCurrent=date.add(Duration(hours:  int.parse(time.split(":")[0])));
      //dateCurrent.add(Duration(minutes:  int.parse(time.split(":")[1])));
       return  DateTime.parse(formatted+" "+time);

    }catch(e)
    {
      return date;
    }
  }
  static String convertDateTimeToString(DateTime date, String time)
  {
    try {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(date);
      //DateTime dateCurrent=date.add(Duration(hours:  int.parse(time.split(":")[0])));
      //dateCurrent.add(Duration(minutes:  int.parse(time.split(":")[1])));
      return  formatted+" "+time;

    }catch(e)
    {
      return "";
    }
  }
  static Color fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }catch(e)
    {
      return Colors.white;
    }
  }


  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8)}';
  }

}
