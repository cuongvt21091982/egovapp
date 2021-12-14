import 'dart:async';

import 'package:badges/badges.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:toast/toast.dart';
class UIUtils
{
  static Color colorsBorder= Colors.grey;
  static Color colorAppBar = Colors.green;
  static Color colorsTitle= Colors.black;
  static Color colorDateTitle= Colors.black12;
  static double fontSizeDate = 10;
  static Color colorsContent = Colors.black;
  static double fontSizeContent =12;
  static double fontSizeFooterItem = 13;
  static double  iconSizeFooterItem = 13;
  static double  iconSizeTitle = 17;
  static double iconSizeNotification =20;
  static double iconSizeBottom =25;
  static double fontSizeNotification =12;
  static Color colorIconFooterItem = Colors.black54;
  static Color colorDialog = Colors.blue;
  static EdgeInsets paddingSearhAppBar = EdgeInsets.fromLTRB(30,19,30,0);
  static EdgeInsets paddingButtonSearchAppBar = EdgeInsets.fromLTRB(0,12,0,0);
  static EdgeInsets iconNotificationPadding= EdgeInsets.fromLTRB(0,12,0,0);
  static BadgePosition badgePosition= BadgePosition.topEnd(top: 2, end: 3);
  static TextStyle  textStyleContentItem= TextStyle(color: colorsContent,fontSize: fontSizeContent);
  static TextStyle  textStyleFooterItem= TextStyle(color: colorIconFooterItem, fontSize: fontSizeFooterItem);
  static Icon iconButtonSearch = Icon(Icons.search);
  static Icon iconButtonYear = Icon(Icons.calendar_today_rounded);
  static TextStyle  textStyleSearch= TextStyle(color: Colors.white, fontSize: 15.0);
  static Color colorButtonSearch = Colors.white;
  static Icon iconCodeItem = Icon( Icons.adjust_outlined, color: colorIconFooterItem, size: iconSizeFooterItem,);
  static Icon iconStaffItem = Icon( Icons.account_circle, color: colorIconFooterItem, size: iconSizeFooterItem,);
  static Icon iconCountItem = Icon( Icons.add_reaction_outlined, color: colorIconFooterItem, size: iconSizeFooterItem,);
  static Icon iconDateSuccessItem = Icon( Icons.calendar_today_rounded, color: colorIconFooterItem, size: iconSizeFooterItem,);
  static TextStyle  textStyleTitleItem= TextStyle(fontWeight: FontWeight.normal, color: colorsTitle, fontSize: 14);
  static TextStyle  textStyleTitleDetailItem= TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 18);
  static TextStyle  textStyleTitleDateItem= TextStyle(fontSize: 12, color: colorsTitle);
  static EdgeInsets paddingLite=  EdgeInsets.fromLTRB(5.0, 0.0,5.0, 0.0);
  static EdgeInsets paddingListView=  EdgeInsets.fromLTRB(10.0, 5.0,0.0, 5.0);
  static EdgeInsets paddingLiteSubTitle=  EdgeInsets.fromLTRB(0,5,0,5);
  static EdgeInsets paddingLiteContentSubTitle=  EdgeInsets.fromLTRB(0,5,0,5);
  static EdgeInsets paddingLiteTitle=  EdgeInsets.fromLTRB(0,3,0,0);
  static EdgeInsets paddingForm=  EdgeInsets.fromLTRB(5.0, 5.0,5.0, 5.0);
  static EdgeInsets paddingBottom= EdgeInsets.fromLTRB(0,0,0,30);
  static Color colorBottomIconButton= Colors.white;
  static double sizeBottomIconButton=30;
  static Text setTextNotification(String value)
  {
    return Text(value, style: TextStyle(color: Colors.white, fontSize: fontSizeNotification));
  }
  static Row setMenuIconText(String text, IconData icon)
  {
      return  Row(children: [
         setTextUserName(text),
          Icon(
            icon,
            size: UIUtils.iconSizeNotification,
            color: Colors.black.withOpacity(0.60),
          )
        ]) ;
  }
  static Text  getTextStatus(int status)
  {
    if(status == ParamUtils.statusChuaXuLy) {
      return Text(Language.getText("chuaxuly"),
          style: TextStyle(color: Colors.amber,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic
             )
      );
    }
    if(status ==  ParamUtils.statusDangXuLy)
    {
      return Text(Language.getText("dangxuly"),
          style: TextStyle(color: Colors.indigo,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }

    if(status == ParamUtils.statusHoanThanh)
    {
      return Text(Language.getText("hoanthanh"),
          style: TextStyle(color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    if(status == ParamUtils.statusChoGiaoXuLy)
    {
      return Text(Language.getText("chogiaoxuly"),
          style: TextStyle(color: Colors.deepPurple,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    if(status == ParamUtils.statusPhoCapKhongGiao)
    {
      return Text(Language.getText("phocapkhonggiao"),
          style: TextStyle(color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    if(status == ParamUtils.statusKhongXuLy)
    {
      return Text(Language.getText("khongxuly"),
          style: TextStyle(color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    if(status == ParamUtils.statusGuiDichDanh)
    {
      return Text(Language.getText("guidichdanh"),
          style: TextStyle(color: Colors.cyan,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    if(status == ParamUtils.statusTraLaiVanThu)
    {
      return Text(Language.getText("tralaivanthu"),
          style: TextStyle(color: Colors.pink,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    return Text(Language.getText("soanthao"),
        style: TextStyle(color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic)
    );
  }

  static Text  getTextStatusApproved(int status)
  {
    if(status ==  ParamUtils.statusDangXuLy)
    {
      return Text(Language.getText("tuchoi"),
          style: TextStyle(color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }

    if(status == ParamUtils.statusHoanThanh)
    {
      return Text(Language.getText("dapheduyet"),
          style: TextStyle(color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic)
      );
    }
    return Text(Language.getText("chopheduyet"),
        style: TextStyle(color: Colors.yellowAccent,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic
        )
    );
  }
  static Text getNoteRequired()
  {
    return Text(Language.getText("note_required"),
        style: TextStyle(color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic)
    );
  }

  static Icon  getIconStatus(int status)
  {
    return getIconByStatus(status, Icons.access_time_filled_rounded);
  }
  static Icon  getIconGhim(int status)
  {
    if(status == ParamUtils.statusON)
      return Icon( Icons.star, color: Colors.blue, size: iconSizeTitle);

    return Icon( Icons.star_border_outlined, color: Colors.blue, size: iconSizeTitle);
  }
  static Icon  getIconPerson()
  {
    return Icon( Icons.account_circle_rounded, color: Colors.green, size: iconSizeTitle);
  }
  static Icon  getIconPosition()
  {
    return Icon( Icons.location_on_sharp, color: Colors.green, size: iconSizeTitle);
  }
  static Icon  getIconDate()
  {
    return Icon( Icons.access_time_filled_rounded, color: Colors.green, size: iconSizeTitle);
  }
  static Icon  getIconSo()
  {
    return Icon( Icons.ac_unit_outlined, color: Colors.green, size: iconSizeTitle);
  }
  static Icon  getIconRead()
  {
    return Icon( Icons.contactless, color: Colors.red, size: iconSizeTitle);
  }
  static Icon  getIconLevel()
  {
    return Icon( Icons.assignment_ind_rounded , color: Colors.blueAccent, size: iconSizeTitle);
  }
  static Icon  getIconByStatus(int status, IconData icon)
  {
    if(status == ParamUtils.statusChuaXuLy)
      return Icon( icon, color: Colors.amber, size: iconSizeTitle);
    if(status ==  ParamUtils.statusDangXuLy)
      return Icon( icon, color: Colors.indigo, size: iconSizeTitle);
    if(status == ParamUtils.statusHoanThanh)
      return Icon( icon, color: Colors.green, size: iconSizeTitle);
    return Icon( icon, color: Colors.grey, size: iconSizeTitle);
  }
  static Icon  getIconDashBoard(IconData icon)
  {
      return Icon( icon, color: Colors.green, size: 50);

  }
  static Icon  getIconCodeStatus(int status)
  {
    return getIconByStatus(status, Icons.adjust_outlined);
  }
  static Icon  getIconAttachFile()
  {
    return Icon( Icons.attach_file, color: Colors.black, size: iconSizeTitle);
  }
  static Icon  getIconCountStatus(int status)
  {
    return getIconByStatus(status, Icons.add_reaction_outlined);
  }
  static Expanded setTextHeaderItem(String value)
  {

   return  Expanded
      (
        flex: 10,
        child:  Text(value, style: textStyleTitleItem,
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis)
    );

  }
  static Text setTextThongBaoItem(String value)
  {
      return
      Text(value, style: TextStyle(fontWeight: FontWeight.normal, color: colorsTitle, fontSize: 14, fontStyle: FontStyle.italic),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis);


  }
  static Text setTextHeaderEmailItem(String value,int read)
  {
    return Text(value, style: TextStyle(fontWeight: (read==0? FontWeight.bold: FontWeight.normal), color: colorsTitle, fontSize: 14),
            maxLines: 10,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify);


  }

  static Text setTextAssignItem(String value)
  {
    return Text(value, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis);


  }
  static Text setTextUserItem(String value)
  {
    return Text(value, style: TextStyle(fontWeight: FontWeight.normal,  color: Colors.blue, fontSize: 13, fontStyle: FontStyle.italic));
    /*return  Expanded
      (
        flex: 10,
        child:  Text(value, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 13),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis)
    );*/

  }
  static Expanded setTextHeaderCommentItem(String value)
  {
    return  Expanded
      (
        flex: 3,
        child:  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 14),
            maxLines: 3 )
    );

  }
  static Expanded setTextContent(String value)
  {
    return  Expanded
      (
        flex: 3,
        child:  Text(value, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black,
            fontSize: 14,),
            textAlign: TextAlign.justify)
    );

  }
  static Expanded setTextUserName(String value)
  {

    return  Expanded
      (
        flex: 10,
        child:  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis)
    );

  }
  static Expanded setTextBold(String value)
  {

    return  Expanded
      (
        flex: 10,
        child:  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis)
    );

  }
  static Text setTextBoldMulti(String value)
  {

   return Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis);


  }
  static Text setTextBoldTitle(String value)
  {
    return  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14));

  }
  static Text setTextAppTitle(String value)
  {
    return  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14));

  }
  static Text setTextBoldRedTitle(String value)
  {
    return  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 14) );

  }
  static Text setTextLocationTitle(String value)
  {
    return Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
        maxLines: 3,
        softWrap: false,
        overflow: TextOverflow.ellipsis);


  }
  static Text setTextBoldWeekTitle(int day, String dayWeek)
  {
    if(day==0)
    return  Text(Language.getText("monday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));
    if(day==1)
      return  Text(Language.getText("tuesday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));
    if(day==2)
      return  Text(Language.getText("wednesday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));
    if(day==3)
      return  Text(Language.getText("thursday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));
    if(day==4)
      return  Text(Language.getText("friday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));
    if(day==5)
      return  Text(Language.getText("saturday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));

      return  Text(Language.getText("sunday")+" (${dayWeek})", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14));
  }
  static Expanded setTextUserNameLevel(String value)
  {

    return  Expanded
      (
        flex: 3,
        child:  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 14),
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.ellipsis)
    );

  }
  static Text setTextNameFile(String value)
  {

    return   Text(value, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.red, fontSize: 12,fontStyle: FontStyle.italic));


  }


  static Text setTextHeaderDetailItem(String value) {
    return  Text(value, style: textStyleTitleDetailItem,
            maxLines: 10,
            softWrap: false,
            overflow: TextOverflow.ellipsis);

  }
  static Text setTextContentItem(String value)
  {
    return  Text(value, style: textStyleContentItem, textAlign: TextAlign.justify );
  }
  static Text setTextFooterItem(String value)
  {
    return  Text(value, style: textStyleFooterItem);
  }
  static Text setTextStartByItem(String value)
  {
    return  Text(value, style: TextStyle(color: Colors.green, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
  }
  static Text setTextHotByItem(String value)
  {
    return  Text(value, style: TextStyle(color: Colors.red, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
  }
  static Text setTextEndByItem(String value)
  {
    return  Text(value, style: TextStyle(color: Colors.red, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
  }
  static Text setTextFooterByStatusItem(String value, int status)
  {
    if(status == ParamUtils.statusChuaXuLy)
      return  Text(value, style: TextStyle(color: Colors.amber, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status ==  ParamUtils.statusDangXuLy)
      return Text(value, style: TextStyle(color: Colors.indigo, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status == ParamUtils.statusHoanThanh)
      return Text(value, style: TextStyle(color: Colors.green, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status == ParamUtils.statusChoGiaoXuLy)
      return Text(value, style: TextStyle(color: Colors.deepPurple, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status == ParamUtils.statusPhoCapKhongGiao)
      return Text(value, style: TextStyle(color: Colors.black45, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status == ParamUtils.statusKhongXuLy)
      return Text(value, style: TextStyle(color: Colors.red, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status == ParamUtils.statusGuiDichDanh)
      return Text(value, style: TextStyle(color: Colors.cyan, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    if(status == ParamUtils.statusTraLaiVanThu)
      return Text(value, style: TextStyle(color: Colors.pink, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
    return Text(value, style: TextStyle(color: Colors.grey, fontSize: fontSizeFooterItem, fontStyle: FontStyle.italic));
  }
  static Expanded setTextHeaderByStatusItem(String value, int status)
  {
    if(status == ParamUtils.statusChuaXuLy)
      return  Expanded
      (
        flex: 5,
          child: Text(value, style: TextStyle(color: Colors.amber, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold),maxLines: 5)
      );
    if(status ==  ParamUtils.statusDangXuLy)
      return  Expanded
      (
        flex: 5,
        child:Text(value, style: TextStyle(color: Colors.indigo, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    if(status == ParamUtils.statusHoanThanh)
      return  Expanded
        (
          flex: 5,
          child: Text(value, style: TextStyle(color: Colors.green, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    if(status == ParamUtils.statusChoGiaoXuLy)
      return  Expanded
        (
          flex: 5,
          child:Text(value, style: TextStyle(color: Colors.deepPurple, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    if(status == ParamUtils.statusPhoCapKhongGiao)
      return  Expanded
        (
          flex: 5,
          child:Text(value, style: TextStyle(color: Colors.black45, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    if(status == ParamUtils.statusKhongXuLy)
      return  Expanded
        (
          flex: 5,
          child:Text(value, style: TextStyle(color: Colors.red, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    if(status == ParamUtils.statusGuiDichDanh)
      return  Expanded
        (
          flex: 5,
          child:Text(value, style: TextStyle(color: Colors.cyan, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    if(status == ParamUtils.statusTraLaiVanThu)
      return  Expanded
        (
          flex: 5,
          child: Text(value, style: TextStyle(color: Colors.pink, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
      );
    return  Expanded
      (
        flex: 5,child: Text(value, style: TextStyle(color: Colors.grey, fontSize: fontSizeFooterItem, fontWeight: FontWeight.bold))
    );
  }
  static Text setNamePerson(String value)
  {
    return Text(value, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic));
  }
  static Text setDescriptionComment(String value)
  {
    return Text(value, style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic));
  }
  static Expanded setDescriptionLevel(String value)
  {
    return Expanded
      (
      flex: 5,
    child: Text(value,
        style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
        maxLines: 5

    ));
  }
  static Text setNamePersonReceive(String value)
  {
    return  Text(value,
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
            maxLines: 10,
            textAlign: TextAlign.left,
        );
  }
  static Text setTextLong(String value)
  {
    return  Text(value,
      style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
      maxLines: 10,
      textAlign: TextAlign.left,
    );
  }
  static Text setUserNameLevel(String value)
  {
    return Text(value, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
      maxLines: 3,
    );
  }
  static Text setNameDate(String value)
  {
    return Text(value, style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic));
  }

  static Text setNameWeekCalendar(String value)
  {
    return Text(value, style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,);
  }
  static Expanded setNameDanhMuc(String value)
  {
    return  Expanded
      (
        flex: 2,
        child:  Text(value, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic))
    );


  }
  static Text setNameFile(String value)
  {
    return Text(value, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic));
  }
  static CircleAvatar setCircleAvatarStatusItem(String value, int status)
  {
    if(status == ParamUtils.statusChuaXuLy)
     return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.amber,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.white)),
      );
    if(status ==  ParamUtils.statusDangXuLy)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.indigo,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.white)),
      );
    if(status == ParamUtils.statusHoanThanh)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.green,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.white)),
      );
    if(status == ParamUtils.statusChoGiaoXuLy)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.deepPurple,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.yellow)),
      );
    if(status == ParamUtils.statusPhoCapKhongGiao)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.black45,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.yellow)),
      );

    if(status == ParamUtils.statusKhongXuLy)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.red,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.yellow)),
      );
    if(status == ParamUtils.statusGuiDichDanh)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.cyan,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.yellow)),
      );
    if(status == ParamUtils.statusTraLaiVanThu)
      return CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.pink,
        child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.yellow)),
      );
    return  CircleAvatar(
      maxRadius: 15,
      backgroundColor: Colors.grey,
      child: Text(value.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.yellow)),
    );


  }
  static Text setTextDateHeaderItem(String value)
  {
    return  Text(value, style: textStyleTitleDateItem);
  }
  static BoxDecoration setBorderBox()
  {
    return BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 0.5,
                color: colorsBorder,
                style: BorderStyle.solid
            )
        )
    );
  }
  static BoxDecoration setBorderBoxTitle()
  {
    return BoxDecoration(
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      border: Border.all(color: Colors.black, width: 0.5),
    );
  }
  static Html setContentHtml(String value)
  {
     return Html(
       data: value
     );
  }
  static void showToastError(String msg, BuildContext context) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.red);
  }
  static void showToastSuccess(String msg, BuildContext context) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.green);
  }
  static void showToastWarning(String msg, BuildContext context) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.yellow);
  }
  static Expanded setHtmlContentItem(String value)
  {
    return  Expanded
      (
        flex: 10,
        child:  Html(data : value)
    );
  }
  static Html setHtmlItem(String value)
  {
    return Html(data : value);

  }
  static Widget noFoundItem(BuildContext context) {
    return Center(
      child: Text(Language.getText('nofounditems'), style: TextStyle(color: Colors.red, fontSize: 15)),
    );
  }
  static Icon setIconButtonElevated(IconData icon)
  {
    return   Icon(icon, size: 14);
  }
  static InputDecoration setInputDecoration(String title, String hint, bool validate)
  {
    return InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(
          ),
        ),
        labelStyle: TextStyle(color: validate == true ? Colors.red: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
        hintStyle: TextStyle(color: validate == true ? Colors.red: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
        labelText: title,
        hintText:  hint);
  }
  static InputDecoration setInputDecorationNoLine(String title, String hint, bool validate)
  {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(30.0),
            borderSide: new BorderSide(
            )

        ),
        labelStyle: TextStyle(color: validate == true ? Colors.red: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
        hintStyle: TextStyle(color: validate == true ? Colors.red: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),

        hintText:  hint);
  }
  static InputDecoration setInputDecorationIcon(IconData icon,Color color,String title, String hint, bool validate)
  {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(30.0),
            borderSide: new BorderSide(
            )

        ), prefixIcon: Icon(icon),
        labelStyle: TextStyle(color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
        hintStyle: TextStyle(color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),

        hintText:  hint);
  }
  static InputDecoration setInputAppBarDecoration(String title, String hint, bool validate)
  {
    return InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(30,15,0,0),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(0.0),

          borderSide: new BorderSide(
            width: 0,
            color: Colors.green
          ),
        ),
        labelStyle: TextStyle(color: validate == true ? Colors.red: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,

        ),
        hintStyle: TextStyle(color: validate == true ? Colors.red: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),

        hintText:  hint);
  }
  static ButtonStyle setButtonStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue));
  }
  static ButtonStyle setButtonAttachStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange));
  }
  static ButtonStyle setButtonAttachViewStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green));
  }
  static ButtonStyle setButtonTrinhViewStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink));
  }
  static ButtonStyle setNoButtonAttachViewStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent));
  }
  static ButtonStyle setButtonUserStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue));
  }
  static ButtonStyle setButtonUserGroupStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange));
  }
  static ButtonStyle setButtonConfirmStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue));
  }
  static ButtonStyle setButtonRadius(Color color)
  {
    return ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(100, 50)),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: color)
            )
        )
    );
  }
  static BoxDecoration setBoxBottomContainer()
  {
    return BoxDecoration(
        border: Border.all(color: Colors.yellowAccent, width: 0.0,style: BorderStyle.solid), //Border.all
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(00.0),
          bottomRight: Radius.circular(00.0),
        ),
        boxShadow:[ BoxShadow(
          color: colorAppBar,
          offset: const Offset(
            0.0,
            0.0,
          ),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        )
        ]
    );
  }
  static BoxDecoration setBoxContainer()
  {
    return BoxDecoration(
        border: Border.all(color: colorAppBar, width: 2.0,style: BorderStyle.solid), //Border.all
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow:[ BoxShadow(
          color: Colors.white,
          offset: const Offset(
            0.0,
            0.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 0.0,
        )
        ]
    );
  }
  static ButtonStyle setButtonCancelStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red));
  }
  static Icon setButtonIcon(IconData icon)
  {
    return Icon( icon, color: Colors.white, size: 23);
  }
  static Icon setNoButtonIcon(IconData icon)
  {
    return Icon( icon, color: Colors.red, size: 15);
  }
  static Icon setButtonRemoveIcon(IconData icon)
  {
    return Icon( icon, color: Colors.red, size: 23);
  }
  static Icon setButtonRemoveUserIcon(IconData icon)
  {
    return Icon( icon, color: Colors.red, size: 30);
  }
  static Text setButtonText(String title)
  {
    return Text(title, style : TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal));
  }
  static Text setNoButtonText(String title)
  {
    return Text(title, style : TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic));
  }
  static Text setButtonFileText(String title)
  {
    return Text(title, textAlign: TextAlign.left, style : TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.normal,fontStyle:  FontStyle.italic));
  }
  static Text setButtonUserText(String title)
  {
    return Text(title, textAlign: TextAlign.left, style : TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold));
  }
  static ButtonStyle setButtonSubmitStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green));
  }
  static ButtonStyle setButtonRejectStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red));
  }
  static ButtonStyle setButtonApprovedStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green));
  }
  static Text setButtonSubmitText(String title)
  {
    return Text(title, style : TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold));
  }
  static ButtonStyle setButtonResetStyle( )
  {
    return ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent));
  }
  static Text setButtonResetText(String title)
  {
    return Text(title, style : TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold));
  }
  static Text setButtonCustomText(String title,Color color, double size)
  {
    return Text(title, style : TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold));
  }
  static Completer createProgressCustom(BuildContext context, String message)
  {
    final dialogContextCompleter = Completer<BuildContext>();
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        if(!dialogContextCompleter.isCompleted) {
          dialogContextCompleter.complete(dialogContext);
        }
        return Dialog(
          child: new Container(
            decoration: setBoxDecoration(),
            width: 300.0,
            height: 100.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 10.0,
                      color: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Center(
                    child: new Text(
                      message,
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return dialogContextCompleter;
  }
  static Completer progressAction(BuildContext context)
  {
    return createProgressCustom(context, Language.getText('progress_action'));

  }
  static Completer progressLoginAction(BuildContext context)
  {
    return createProgressCustom(context, Language.getText('progress_login'));

  }
  static Completer progressLoadCustom(BuildContext context)
  {
    return createProgressCustom(context, Language.getText('progress_load'));

  }
  static BoxDecoration setBoxDecoration()
  {
    return BoxDecoration(
      color: Colors.green,
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      border: Border.all(color: Colors.yellowAccent, width: 3),
        boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
  ],
    );
  }
  static BoxDecoration setBoxDecorationHot()
  {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      border: Border.all(color: Colors.black12, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
  static BoxDecoration setBoxDecorationDialogCustom()
  {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      border: Border.all(color: Colors.blueAccent, width: 3),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
  static Container progressLoad()
  {
    return new Container(
           //color: Colors.green,
            width: 300.0,
            height: 100.0,
            decoration: setBoxDecoration(),
            alignment: AlignmentDirectional.center,
            child: new Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 10.0,
                      color: Colors.yellow,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Center(
                    child: new Text(
                      Language.getText('progress_load'),
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );


  }
  static HtmlEditor setHtmlEditor( HtmlEditorController controller, String value )
  {
    return HtmlEditor(
        controller: controller, //required
        htmlEditorOptions: HtmlEditorOptions(
        hint: Language.getText('input_content'),
        initialText: value
    ),
    otherOptions: OtherOptions(
    height: 400,
    )
    );
  }
}
