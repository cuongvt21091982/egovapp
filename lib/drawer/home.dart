import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/app-theme.dart';
import 'package:egovapp/service/staffs/service-navitem.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key, this.screenIndex,
    this.iconAnimationController,
    this.callBackIndex}) : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;

  @override
  void initState() {
    loadNavItemData();
    UserAuthSession.getAccount();
    debugPrint('AVATAR:'+UserAuthSession.pathAvatar);
    super.initState();
  }
  void loadNavItemData()
  {
   drawerList = <DrawerList>[
      DrawerList(
          index: DrawerIndex.HOME,
          labelName: Language.getText("home"),
          icon: Icon(Icons.home),
          parent: true,
          code: 'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.Help,
          labelName: Language.getText("trinhbaocao"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'

      ),
      DrawerList(
          index: DrawerIndex.ToTrinhGui,
          labelName: Language.getText("totrinhgui"),
          code:'TTGUI'
      ),
      DrawerList(
          index: DrawerIndex.ToTrinhDangSoan,
          labelName: Language.getText("totrinhdangsoan"),
          code:'TTDANGSOAN'
      ),
     DrawerList(
         index: DrawerIndex.ToTrinhNhan,
         labelName: Language.getText("totrinhnhan"),
         code:'TTNHAN'
     ),
     DrawerList(
         index: DrawerIndex.ToTrinhChuaXuLy,
         labelName: Language.getText("totrinhchuaxuly"),
         code:'TTNHAN'
     ),
     DrawerList(
         index: DrawerIndex.ToTrinhDangXuLy,
         labelName: Language.getText("totrinhdangxuly"),
         code:'TTNHAN'
     ),
     DrawerList(
         index: DrawerIndex.ToTrinhHoanThanh,
         labelName: Language.getText("totrinhhoanthanh"),
         code:'TTNHAN'
     ),
      DrawerList(
          index: DrawerIndex.FeedBack,
          labelName: Language.getText("giaoviec"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.GiaoViecGui,
          labelName: Language.getText("giaoviecgui"),
          code:'YCGUI'
      ),
      DrawerList(
          index: DrawerIndex.GiaoViecDangSoan,
          labelName: Language.getText("giaoviecdangsoan"),
          code:'YCDANGSOAN'
      ),
      DrawerList(
         index: DrawerIndex.GiaoViecNhan,
         labelName: Language.getText("giaoviecnhan"),
         code: 'YCNHAN'
     ),DrawerList(
         index: DrawerIndex.GiaoViecChuaXuLy,
         labelName: Language.getText("giaoviecchuaxuly"),
         code: 'YCNHAN'
     ),DrawerList(
         index: DrawerIndex.GiaoViecDangXuLy,
         labelName: Language.getText("giaoviecdangxuly"),
         code: 'YCNHAN'
     ),DrawerList(
         index: DrawerIndex.GiaoViecHoanThanh,
         labelName: Language.getText("giaoviechoanthanh"),
         code: 'YCNHAN'
     ),
      DrawerList(
          index: DrawerIndex.Invite,
          labelName: Language.getText("homthunoibo"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code: 'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.ThuDaNhan,
          labelName: Language.getText("thunhan"),
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.ThuDaGui,
          labelName: Language.getText("thudagui"),
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.ThuDangSoan,
          labelName: Language.getText("thudangsoan"),
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.ThungRacDaNhan,
          labelName: Language.getText("thungracthudanhan"),
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.ThungRacDaGui,
          labelName: Language.getText("thungracthudagui"),
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("hoptraodoithongtin"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.QLMeeting,
          labelName: Language.getText("thamgiahop"),
          code:'CHOPTGIA'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("thongbao"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.DocThongBao,
        labelName: Language.getText("docthongbao"),
        code:'TBDOC'
      ),
      DrawerList(
        index: DrawerIndex.QLThongBao,
        labelName: Language.getText("qlthongbao"),
        code:'TBQL'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("vanbanden"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDenGiaoXuLy,
        labelName: Language.getText("vanbandenchogiaoxuly"),
        code:'VBDCGXL'
      ),
      DrawerList(
          index: DrawerIndex.VanBanDenDaVaoSo,
          labelName: Language.getText("vanbandendavaoso"),
          code:'VBDDAVS'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDenTatCa,
        labelName: Language.getText("tatcavanbanden"),
        code:'VBDTATCA'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDenChuaXuLy,
        labelName: Language.getText("vanbandenchuaxuly"),
        code:'VBDCXL'
      ),
      DrawerList(
          index: DrawerIndex.VanBanDenDangXuLy,
          labelName: Language.getText("vanbandendangxuly"),
          code:'VBDDXL'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDenHoanThanh,
        labelName: Language.getText("vanbandenhoanthanh"),
        code:'VBDHT'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("vanbandi"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDiGiaoXuLy,
        labelName: Language.getText("vanbandichogiaoxuly"),
        code:'VBDICGXL'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDiDaVaoSo,
        labelName: Language.getText("vanbandidavaoso"),
        code:'VBDIDVS'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDiTatCa,
        labelName: Language.getText("tatcavanbandi"),
        code:'VBDITATCA'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDiChuaXuLy,
        labelName: Language.getText("vanbandichuaxuly"),
        code:'VBDIXL'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDiDangXuLy,
        labelName: Language.getText("vanbandidangxuly"),
          code:'VBDIXL'
      ),
      DrawerList(
        index: DrawerIndex.VanBanDiHoanThanh,
        labelName: Language.getText("vanbandihoanthanh"),
        code:'VBDIXL'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("chucnangchung"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code: 'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.QLKeHoach,
        labelName: Language.getText("kehoach"),
        code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.LichCongTac,
        labelName: Language.getText("lichcongtac"),
        code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.LichDonVi,
        labelName: Language.getText("lichdonvi"),
        code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.LichCaNhan,
        labelName: Language.getText("lichcanhan"),
        code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("tainguyen"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.VanBanPhapQuy,
        labelName: Language.getText("vanbanphapquy"),
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.VanBanPhoCap,
        labelName: Language.getText("vanbanphocap"),
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.MauVanBan,
        labelName: Language.getText("mauvanban"),
        code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("hosocongviec"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.HoSoCaNhan,
        labelName: Language.getText("hosocanhan"),
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.HoSoDonVi,
        labelName: Language.getText("hosodonvi"),
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.HoSoLuuTru,
        labelName: Language.getText("hosoluutru"),
          code:'DEFAULT'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("datxe"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.DatXeXemKetQuaDuyet,
        labelName: Language.getText("xemketquaduyet"),
        code:'XEMKQDUYET'
      ),
      DrawerList(
        index: DrawerIndex.DatXeDuyetYeuCau,
        labelName: Language.getText("duyetyeucau"),
        code:'DUYETYEUCAU'
      ),
      DrawerList(
        index: DrawerIndex.DatXeTheoDoiYeuCau,
        labelName: Language.getText("theodoiyeucau"),
        code:'TDYEUCAU'
      ),
      DrawerList(
          index: DrawerIndex.About,
          labelName: Language.getText("dangkylich"),
          icon: Icon(Icons.navigate_next),
          parent: true,
          code:'DEFAULT'
      ),
      DrawerList(
        index: DrawerIndex.DatPhongKetQuaXepLichPhong,
        labelName: Language.getText("ketquaxeplichphong"),
        code:'KQXEPLICHPHONG'
      ),
      DrawerList(
        index: DrawerIndex.DatPhongSapXepLich,
        labelName: Language.getText("sapxeplich"),
        code:'SAPXEPLICH'
      ),
      DrawerList(
        index: DrawerIndex.DatPhongTheoDoiDatLich,
        labelName: Language.getText("theodoidatlich"),
        code:'TDDATLICH'
      ),
    ];
    ServiceNavItem().findALlByStaffId(UserAuthSession.staffId, -1, true).then((value) {
        List<DrawerList> drawListReal=[];
        for(DrawerList item in drawerList!)
          {
            if(item.code != 'DEFAULT') {
              if (value.indexWhere((element) => element.code == item.code) !=
                  -1)
                drawListReal.add(item);
            }
            else
                drawListReal.add(item);
          }
        setState(() {
          this.drawerList= drawListReal;
        });

    }).catchError((e){
      UIUtils.showToastError('SERVICE ITEM :'+e.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var futureAvatar =     InkWell(child:CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(UserAuthSession.pathAvatar)
            ));
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child)  {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 - (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(begin: 0.0, end: 24.0)
                              .animate(CurvedAnimation(parent: widget.iconAnimationController!, curve: Curves.fastOutSlowIn))
                              .value /
                              260),
                          child: Container(
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppTheme.grey.withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8),
                              ],
                            ),
                            child: futureAvatar,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 30, right: 0),
                    child: Text(
                      UserAuthSession.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 30, right: 0),
                    child: Text(
                      UserAuthSession.chucVuName+" - "+UserAuthSession.unitName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.dark_grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  Language.getText("exit"),
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  onTapped();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void onTapped() {
    print('Doing Something...'); // Print to console.
  }
  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 30.0
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                    width: 24,
                    height: 10,
                    child: Image.asset(listData.imageName, color: widget.screenIndex == listData.index ? Colors.blue : AppTheme.nearlyBlack),
                  )
                      : Icon(listData.icon?.icon, color: widget.screenIndex == listData.index ? Colors.pink : Colors.red),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                  ),
                  Text(
                    listData.parent== true? listData.labelName: listData.labelName,
                    style: TextStyle(
                      fontWeight: listData.parent == true? FontWeight.bold : FontWeight.w500,
                      fontSize: 12,
                      color: widget.screenIndex == listData.index ? Colors.red : Colors.black,
                    ),
                    textAlign: TextAlign.left
                  )

                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
              animation: widget.iconAnimationController!,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.translationValues(
                      (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController!.value - 1.0), 0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    child: Container(
                     // width: MediaQuery.of(context).size.width * 0.75 - 64,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  ToTrinhGui,
  ToTrinhDangSoan,
  ToTrinhNhan,
  ToTrinhChuaXuLy,
  ToTrinhDangXuLy,
  ToTrinhHoanThanh,
  GiaoViecGui,
  GiaoViecNhan,
  GiaoViecChuaXuLy,
  GiaoViecDangXuLy,
  GiaoViecHoanThanh,
  GiaoViecDangSoan,
  Help,
  VanBanDen,
  VanBanDenGiaoXuLy,
  VanBanDenChuaXuLy,
  VanBanDenDangXuLy,
  VanBanDenHoanThanh,
  VanBanDenDaVaoSo,
  VanBanDenTatCa,
  VanBanDiGiaoXuLy,
  VanBanDiChuaXuLy,
  VanBanDiDangXuLy,
  VanBanDiHoanThanh,
  VanBanDiDaVaoSo,
  VanBanDiTatCa,
  QLMeeting,
  DocThongBao,
  QLThongBao,
  ThuDaNhan,
  ThuDaGui,
  ThuDangSoan,
  ThungRacDaNhan,
  ThungRacDaGui,
  LichCongTac,
  LichDonVi,
  LichCaNhan,
  QLKeHoach,
  VanBanPhapQuy,
  VanBanPhoCap,
  MauVanBan,
  HoSoCaNhan,
  HoSoDonVi,
  HoSoLuuTru,
  DatXeXemKetQuaDuyet,
  DatXeTheoDoiYeuCau,
  DatXeDuyetYeuCau,
  DatPhongKetQuaXepLichPhong,
  DatPhongSapXepLich,
  DatPhongTheoDoiDatLich,
  InforAccount,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.code='',
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
    this.parent = false

  });
  String code;
  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  bool parent = false;


  DrawerIndex? index;
}
