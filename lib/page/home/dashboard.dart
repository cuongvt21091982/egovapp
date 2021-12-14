import 'package:badges/badges.dart';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:egovapp/page/home/login.dart';
import 'package:egovapp/page/notification/notification-page.dart';
import 'package:egovapp/service/calendar/service-calendardepart.dart';
import 'package:egovapp/service/calendar/service-calendarnews.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:egovapp/service/meeting/service-meeting.dart';
import 'package:egovapp/service/staffs/service-navitem.dart';
import 'package:egovapp/service/staffs/service-notification.dart';
import 'package:egovapp/service/thongbao/service-thongbao.dart';
import 'package:egovapp/service/totrinh/service-totrinhxuly.dart';
import 'package:egovapp/service/vanbanden/service-vanbanden.dart';
import 'package:egovapp/service/vanbandi/service-vanbandi.dart';
import 'package:egovapp/service/yeucau/service-yeucauxuly.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class DashBoardPage extends StatefulWidget  {
  const DashBoardPage({Key? key}) : super(key: key);
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}
class _DashBoardPageState extends State<DashBoardPage>  {
  int newVBDenCXL=0;
  int newVBDiCXL=0;
  int newThongBao=0;
  int newMeeting=0;
  int newToTrinh=0;
  int newGiaoViec=0;
  int newLichCongTac=0;
  int newLichDonVi=0;
  int newThuNhan=0;
  int totalVBDenCXL= 0;
  int totalVBDenDXL= 0;
  int totalVBDiCXL= 0;
  int totalVBDiDXL= 0;
  int totalThongBao= 0;
  int totalMeeting= 0;
  int totalLichDonVi= 0;
  int totalLichCongTac= 0;
  int totalGiaoViecCXL=0;
  int totalGiaoViecDXL=0;
  int totalToTrinhCXL=0;
  int totalToTrinhDXL=0;
  int totalThuNhan= 0;
  String fromDate=ParamUtils.dateDefault;
  String toDate=ParamUtils.dateDefault;
  List<int> list = [1, 2, 3, 4, 5];
  List<ThongBao> thongBaoHotList=[];
  @override
  void initState() {

    ApiUtils().getToken().then((value) {
      if(value == false)
      {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new LoginPage(),
          ),
        );
      }
    });
    super.initState();
    loadData();
    receiveMessage();
  }

  void loadData() async
  {

    loadVBDenXL(ParamUtils.statusChuaXuLy);
    loadVBDenXL(ParamUtils.statusDangXuLy);
    loadVBDiXL(ParamUtils.statusChuaXuLy);
    loadVBDiXL(ParamUtils.statusDangXuLy);
    loadToTrinh(ParamUtils.statusChuaXuLy);
    loadToTrinh(ParamUtils.statusDangXuLy);
    loadYeuCau(ParamUtils.statusChuaXuLy);
    loadYeuCau(ParamUtils.statusDangXuLy);
    loadMeeting();
    loadThongBao();
    loadLichCongTac();
    loadLichDonVi();
    loadThuNhan();
    loadNew();
  }
  void loadNew() async
  {
    ServiceNotification().getPaging(UserAuthSession.staffId, ParamUtils.statusNotification,'', 1,1000).then((value) {
      if(this.mounted) {
        setState(() {
          newToTrinh = value
              .where((element) => element.notificationType == 'TOTRINH')
              .length;
          newThuNhan = value
              .where((element) => element.notificationType == 'THUNHAN')
              .length;
          newVBDiCXL = value
              .where((element) => element.notificationType == 'VBDI')
              .length;
          newVBDenCXL = value
              .where((element) => element.notificationType == 'VBDEN')
              .length;
          newThongBao = value
              .where((element) => element.notificationType == 'THONGBAO')
              .length;
          newMeeting = value
              .where((element) => element.notificationType == 'MEETING')
              .length;
          newGiaoViec = value
              .where((element) => element.notificationType == 'YEUCAU')
              .length;
          newLichCongTac = value
              .where((element) => element.notificationType == 'LICHCONGTAC')
              .length;
          newLichDonVi = value
              .where((element) => element.notificationType == 'LICHDONVI')
              .length;
        });
      }
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });

  }
  void receiveMessage()
  {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        ServiceNotification().getByMessageId(message.messageId!).then((value) {
          loadNew();
          switch(value.notificationType)
          {
            case 'TOTRINH':
              loadToTrinh(ParamUtils.statusChuaXuLy);
              break;
            case 'THUNHAN':
              loadThuNhan();
              break;
            case 'VBDI':
              loadVBDiXL(ParamUtils.statusChuaXuLy);
              break;
            case 'VBDEN':
            loadVBDenXL(ParamUtils.statusChuaXuLy);
            break;
            case 'THONGBAO':
              loadThongBao();
              break;
            case 'MEETING':
              loadMeeting();
              break;
            case 'LICHCONGTAC':
              loadLichCongTac();
              break;
            case 'LICHDONVI':
              loadLichDonVi();
              break;
            case 'YEUCAU':
              loadYeuCau(ParamUtils.statusChuaXuLy);
              break;
          }
        }).catchError((e){
          UIUtils.showToastError(e.toString(), context);
        });

    });
  }
  void loadVBDenXL(int status) async
  {
      ServiceVanBanDen().getCountXuLy('',ParamUtils.valueDefault,ParamUtils.valueDefault,
          status.toString(),
          ParamUtils.valueDefault, UserAuthSession.staffId,
          ParamUtils.valueDefault,
          ParamUtils.valueDefault,
          ParamUtils.valueDefault,
          fromDate,toDate).then((value) {
        if(this.mounted) {
          setState(() {
            if (status == ParamUtils.statusChuaXuLy)
              totalVBDenCXL = value;
            if (status == ParamUtils.statusDangXuLy)
              totalVBDenDXL = value;
          });
        }
      });
  }
  void loadVBDiXL(int status) async
  {
    ServiceVanBanDi().getCountXuLy('',ParamUtils.valueDefault,ParamUtils.valueDefault,
        status.toString(),
        ParamUtils.valueDefault, UserAuthSession.staffId,
        ParamUtils.valueDefault,
        ParamUtils.valueDefault,
        fromDate,toDate).then((value) {
      if(this.mounted) {
        setState(() {
          if (status == ParamUtils.statusChuaXuLy)
            totalVBDiCXL = value;
          if (status == ParamUtils.statusDangXuLy)
            totalVBDiDXL = value;
        });
      }
    });
  }
  void loadToTrinh(int status) async
  {
    ServiceToTrinhXuLy().getCount('',status.toString(),
        UserAuthSession.staffId,
        ParamUtils.valueDefault,
        fromDate,toDate).then((value) {
      if(this.mounted) {
        setState(() {
          if (status == ParamUtils.statusChuaXuLy)
            totalToTrinhCXL = value;
          if (status == ParamUtils.statusDangXuLy)
            totalToTrinhDXL = value;
        });
      }
    });
  }
  void loadYeuCau(int status) async
  {
    ServiceYeuCauXuLy().getCount('',status.toString(),
        UserAuthSession.staffId,
        ParamUtils.valueDefault,
        fromDate,toDate).then((value) {
      if(this.mounted) {
        setState(() {
          if (status == ParamUtils.statusChuaXuLy)
            totalGiaoViecCXL = value;
          if (status == ParamUtils.statusDangXuLy)
            totalGiaoViecDXL = value;
        });
      }
    });
  }
  void loadMeeting() async
  {
    ServiceMeeting().getCount('',ParamUtils.statusArrayAll,
        UserAuthSession.staffId,
        ParamUtils.valueDefault
       ).then((value) {
      if(this.mounted) {
        setState(() {
          totalMeeting = value;
        });
      }
    });
  }
  void loadThongBao()async
  {
    int st= await ServiceNavItem().checkPermissionByCode(UserAuthSession.staffId,"0001", true);
    ServiceThongBao().getCount('',  (st>0? ParamUtils.valueDefault: UserAuthSession.staffId),    ParamUtils.valueDefault
    ).then((value) {
      if(this.mounted) {
        setState(() {
          totalThongBao = value;
        });
      }
    });
    ServiceThongBao().getPaging(ParamUtils.stringEmpty, UserAuthSession.staffId, ParamUtils.valueDefault,
        Enviroments.currentPage, Enviroments.pageSize).then((value) {
          setState(() {
            thongBaoHotList= value;
          });

    });
  }
  void loadLichCongTac() async
  {
      ServiceCalendarNews().getCountSearch('', fromDate,
                                               toDate,
                                               ParamUtils.valueDefault, ParamUtils.valueDefault, ParamUtils.valueDefault)
      .then((value) {
        if(this.mounted) {
          setState(() {
            totalLichCongTac = value;
          });
        }
      });
  }
  void loadLichDonVi() async
  {
    ServiceCalendarDepart().getCountSearch('', fromDate,
        toDate,
        ParamUtils.valueDefault.toString(), ParamUtils.valueDefault, ParamUtils.valueDefault, UserAuthSession.unitId)
        .then((value) {
      if(this.mounted) {
        setState(() {
          totalLichDonVi = value;
        });
      }
    });
  }
  void loadThuNhan() async
  {
    ServiceThu().getCount('', UserAuthSession.staffId, ParamUtils.valueDefault, ParamUtils.statusOFF,
        ParamUtils.statusChuaXuLy.toString())
        .then((value) {
     if(this.mounted) {
       setState(() {
         totalThuNhan = value;
       });
     }
    });
  }
  void notificationVBDen()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'VBDEN'),
      ),
    );
  }
  void notificationVBDi()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'VBDI'),
      ),
    );
  }
  void notificationThongBao()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'THONGBAO'),
      ),
    );
  }
  void notificationYeuCau()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'YEUCAU'),
      ),
    );
  }
  void notificationToTrinh()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'TOTRINH'),
      ),
    );
  }
  void notificationMeeting()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'MEETING'),
      ),
    );
  }
  void notificationLichCongTac()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'LICHCONGTAC'),
      ),
    );
  }
  void notificationLichDonVi()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'LICHDONVI'),
      ),
    );
  }
  void notificationThuNhan()
  {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NotificationPage(type:'THUNHAN'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  new WillPopScope(child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title: UIUtils.setTextAppTitle(Language.getText("egov-dashboard")),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: UIUtils.setBoxDecorationHot(),
           child:  CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  height: 120
              ),
              items: thongBaoHotList
                  .map((item) =>  ListTile(

                title:Column(
                  children: [
                    Row(
                        children: <Widget>[
                          UIUtils.setTextBold(item.chuDe),
                        ]),
                    Row(
                        children: <Widget>[
                          UIUtils.setTextThongBaoItem(Language.getText("nguoichutri")+": "+item.nguoiNhapItem.fullName)
                        ]),
                    Row( children:[
                      UIUtils.setTextHotByItem(item.ngayHieuLuc+' - '+ (item.ngayHetHieuLuc!=''?item.ngayHetHieuLuc: Language.getText("vohan")))
                    ]
                    )

                  ],
                )
                ,
                onTap: (){

                  //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
                }

              ))
                  .toList(),
            ),

        )

      /*CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(0),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("vbdenchuaxuly")),
                            if(newVBDenCXL>0)
                              UIBadgeAction( value: newVBDenCXL.toString(), icon: Icons.list_alt_outlined, tooltip: Language.getText("vbdenchuaxuly"), actionCommand: notificationVBDen),
                            if(newVBDenCXL<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.list_alt_outlined),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("vbdenchuaxuly"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => VBDenChuaXuLy (),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalVBDenCXL.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("vbdendangxuly")),
                            IconButton(
                              icon: UIUtils.getIconDashBoard(Icons.list_alt_outlined),
                              padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                              tooltip: Language.getText("vbdendangxuly"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => VBDenDangXuLy (),
                                  ),
                                );
                              },
                            )
                            ,
                            UIUtils.setTextBoldRedTitle(totalVBDenDXL.toString())
                          ],
                        )
                    ),
                    Container(
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("vbdichuaxuly")),
                            if(newVBDiCXL>0)
                              UIBadgeAction( value: newVBDiCXL.toString(), icon: Icons.account_balance_wallet, tooltip: Language.getText("vbdichuaxuly"), actionCommand: notificationVBDi),
                            if(newVBDiCXL<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.account_balance_wallet),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("vbdichuaxuly"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => VBDiChuaXuLy (),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalVBDiCXL.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("vbdidangxuly")),
                            IconButton(
                              icon: UIUtils.getIconDashBoard(Icons.account_balance_wallet),
                              padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                              tooltip: Language.getText("vbdidangxuly"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => VBDiDangXuLy(),
                                  ),
                                );
                              },
                            )
                            ,
                            UIUtils.setTextBoldRedTitle(totalVBDiDXL.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("giaoviecchuaxuly")),
                            if(newGiaoViec>0)
                              UIBadgeAction( value: newGiaoViec.toString(), icon: Icons.work_outlined, tooltip: Language.getText("giaoviecchuaxuly"), actionCommand: notificationYeuCau),
                            if(newGiaoViec<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.work_outlined),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("giaoviecchuaxuly"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => YeuCauChuaXuLy(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalGiaoViecCXL.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("giaoviecdangxuly")),
                            IconButton(
                              icon: UIUtils.getIconDashBoard(Icons.work_outlined),
                              padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                              tooltip: Language.getText("giaoviecdangxuly"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => YeuCauDangXuLy(),
                                  ),
                                );
                              },
                            )
                            ,
                            UIUtils.setTextBoldRedTitle(totalGiaoViecDXL.toString())
                          ],
                        )
                    ),

                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("totrinhchuaxuly")),
                            if(newToTrinh>0)
                              UIBadgeAction( value: newToTrinh.toString(), icon: Icons.add_business_sharp, tooltip: Language.getText("totrinhchuaxuly"), actionCommand: notificationToTrinh),
                            if(newToTrinh<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.add_business_sharp),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("totrinhchuaxuly"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => ToTrinhChuaXuLy(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalToTrinhCXL.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("totrinhdangxuly")),
                            IconButton(
                              icon: UIUtils.getIconDashBoard(Icons.add_business_sharp),
                              padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                              tooltip: Language.getText("totrinhdangxuly"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => ToTrinhDangXuLy(),
                                  ),
                                );
                              },
                            )
                            ,
                            UIUtils.setTextBoldRedTitle(totalToTrinhDXL.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("thongbao")),
                            if(newThongBao>0)
                              UIBadgeAction( value: newThongBao.toString(), icon: Icons.add_alert_outlined, tooltip: Language.getText("thongbao"), actionCommand: notificationThongBao),
                            if(newThongBao<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.add_alert_outlined),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("thongbao"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => DocThongBao(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalThongBao.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("meeting")),
                            if(newMeeting>0)
                              UIBadgeAction( value: newMeeting.toString(), icon: Icons.alarm_add, tooltip: Language.getText("meeting"), actionCommand: notificationMeeting),
                            if(newMeeting<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.alarm_add),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("meeting"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => QLMeeting(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalMeeting.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("lichcongtac")),
                            if(newLichCongTac>0)
                              UIBadgeAction( value: newLichCongTac.toString(), icon: Icons.calendar_today_outlined, tooltip: Language.getText("lichcongtac"), actionCommand: notificationLichCongTac),
                            if(newLichCongTac<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.calendar_today_outlined),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("lichcongtac"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => LichCongTac(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalLichCongTac.toString())
                          ],
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("lichdonvi")),
                            if(newLichDonVi>0)
                              UIBadgeAction( value: newLichDonVi.toString(), icon: Icons.calendar_today, tooltip: Language.getText("lichdonvi"), actionCommand: notificationLichDonVi),
                            if(newLichDonVi<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.calendar_today),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("lichdonvi"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => LichDonVi(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalLichDonVi.toString())
                          ],
                        )
                    ),

                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: UIUtils.setBoxContainer(),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            UIUtils.setTextBoldTitle(Language.getText("thunhan")),
                            if(newThuNhan>0)
                              UIBadgeAction( value: newThuNhan.toString(), icon: Icons.email, tooltip: Language.getText("thunhan"), actionCommand: notificationThuNhan),
                            if(newThuNhan<=0)
                              IconButton(
                                icon: UIUtils.getIconDashBoard(Icons.email),
                                padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
                                tooltip: Language.getText("thunhan"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => ThuDaNhan(),
                                    ),
                                  );
                                },
                              )
                            ,
                            UIUtils.setTextBoldRedTitle(totalThuNhan.toString())
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ],
          )*/,

        bottomNavigationBar: BottomBarAction(pageCurrent: ParamUtils.bottomPageDashboard),
      ),
          onWillPop: () {
            this.loadData();
            return new Future.value(true);
          });

  }


}

