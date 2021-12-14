import 'package:egovapp/drawer/drawer-user-controller.dart';
import 'package:egovapp/drawer/home.dart';
import 'package:egovapp/menu/app-theme.dart';
import 'package:egovapp/page/calendar/canhan/lich-canhan.dart';
import 'package:egovapp/page/calendar/congtac/lich-congtac.dart';
import 'package:egovapp/page/calendar/donvi/lich-donvi.dart';
import 'package:egovapp/page/datphong/phong-duyetyeucau.dart';
import 'package:egovapp/page/datphong/phong-theodoiyeucau.dart';
import 'package:egovapp/page/datphong/phong-xemketqua.dart';
import 'package:egovapp/page/email/dagui/thu-dagui.dart';
import 'package:egovapp/page/email/dangsoan/thu-dangsoan.dart';
import 'package:egovapp/page/email/danhan/thu-danhan.dart';
import 'package:egovapp/page/email/thungrac/thugui-thungrac.dart';
import 'package:egovapp/page/email/thungrac/thunhan-thungrac.dart';
import 'package:egovapp/page/home/dashboard.dart';
import 'package:egovapp/page/hoso/canhan/hoso-canhan.dart';
import 'package:egovapp/page/hoso/donvi/hoso-donvi.dart';
import 'package:egovapp/page/kehoach/ql-kehoach.dart';
import 'package:egovapp/page/mauvanban/ql-mauvanban.dart';
import 'package:egovapp/page/meeting/ql-meeting.dart';
import 'package:egovapp/page/staffs/info-account.dart';
import 'package:egovapp/page/thongbao/docthongbao/doc-thongbao.dart';
import 'package:egovapp/page/thongbao/qlthongbao/ql-thongbao.dart';
import 'package:egovapp/page/totrinh/totrinh-chuaxuly/totrinh-chuaxuly.dart';
import 'package:egovapp/page/totrinh/totrinh-dangxuly/totrinh-dangxuly.dart';
import 'package:egovapp/page/totrinh/totrinh-hoanthanh/totrinh-hoanthanh.dart';
import 'package:egovapp/page/totrinh/totrinhdangsoan/totrinh-dangsoan.dart';
import 'package:egovapp/page/vanbanden/chogiaoxuly/vbden-chogiaoxuly.dart';
import 'package:egovapp/page/vanbanden/chuaxuly/vbd-chuaxuly.dart';
import 'package:egovapp/page/vanbanden/dangxuly/vbd-dangxuly.dart';
import 'package:egovapp/page/vanbanden/davaoso/vbd-davaoso.dart';
import 'package:egovapp/page/vanbanden/hoanthanh/vbd-hoanthanh.dart';
import 'package:egovapp/page/vanbanden/tatca/vbd-tatca.dart';
import 'package:egovapp/page/vanbandi/chogiaoxuly/vbdi-chogiaoxuly.dart';
import 'package:egovapp/page/vanbandi/chuaxuly/vbdi-chuaxuly.dart';
import 'package:egovapp/page/vanbandi/dangxuly/vbdi-dangxuly.dart';
import 'package:egovapp/page/vanbandi/davaoso/vbdi-davaoso.dart';
import 'package:egovapp/page/vanbandi/hoanthanh/vbdi-hoanthanh.dart';
import 'package:egovapp/page/vanbandi/tatca/vbdi-tatca.dart';
import 'package:egovapp/page/vanbanphapquy/ql-vanbanphapquy.dart';
import 'package:egovapp/page/vpp/vpp-duyetyeucau.dart';
import 'package:egovapp/page/vpp/vpp-theodoiyeucau.dart';
import 'package:egovapp/page/vpp/vpp-xemketqua.dart';
import 'package:egovapp/page/yeucau/yeucauchuaxuly/yeucau-chuaxuly.dart';
import 'package:egovapp/page/yeucau/yeucaudangsoan/yeucau-dangsoan.dart';
import 'package:egovapp/page/yeucau/yeucaudangxuly/yeucau-dangxuly.dart';
import 'package:egovapp/page/yeucau/yeucaugui/yeucau-gui.dart';
import 'package:egovapp/page/yeucau/yeucauhoanthanh/yeucau-hoanthanh.dart';
import 'package:egovapp/page/yeucau/yeucaunhan/yeucau-nhan.dart';
import '../page/totrinh/totrinhgui/totrinh-gui.dart';
import 'package:egovapp/page/totrinh/totrinhnhan/totrinh-nhan.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}
class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const DashBoardPage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = DashBoardPage();
        });
      }else if (drawerIndex == DrawerIndex.ToTrinhDangSoan) {
        setState(() {
          screenView= const ToTrinhDangSoan();
        });
      }
      else if (drawerIndex == DrawerIndex.ToTrinhGui) {
        setState(() {
          screenView= const ToTrinhGui();
        });
      } else if (drawerIndex == DrawerIndex.ToTrinhNhan) {
        setState(() {
          screenView= const ToTrinhNhan();
        });
      }else if (drawerIndex == DrawerIndex.ToTrinhChuaXuLy) {
        setState(() {
          screenView= const ToTrinhChuaXuLy();
        });
      }else if (drawerIndex == DrawerIndex.ToTrinhDangXuLy) {
        setState(() {
          screenView= const ToTrinhDangXuLy();
        });
      }else if (drawerIndex == DrawerIndex.ToTrinhHoanThanh) {
        setState(() {
          screenView= const ToTrinhHoanThanh();
        });
      }else if (drawerIndex == DrawerIndex.GiaoViecDangSoan) {
        setState(() {
          screenView= const YeuCauDangSoan();
        });
      }
      else if (drawerIndex == DrawerIndex.GiaoViecGui) {
        setState(() {
          screenView= const YeuCauGui();
        });
      }else if (drawerIndex == DrawerIndex.GiaoViecNhan) {
        setState(() {
          screenView= const YeuCauNhan();
        });
      }
      else if (drawerIndex == DrawerIndex.GiaoViecChuaXuLy) {
        setState(() {
          screenView= const YeuCauChuaXuLy();
        });
      }else if (drawerIndex == DrawerIndex.GiaoViecDangXuLy) {
        setState(() {
          screenView= const YeuCauDangXuLy();
        });
      }else if (drawerIndex == DrawerIndex.GiaoViecHoanThanh) {
        setState(() {
          screenView= const YeuCauHoanThanh();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDenGiaoXuLy) {
        setState(() {
          screenView= const VBDenChoGiaoXuLy();
        });
      }
      else if (drawerIndex == DrawerIndex.VanBanDenChuaXuLy) {
        setState(() {
          screenView= const VBDenChuaXuLy();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDenDangXuLy) {
        setState(() {
          screenView= const VBDenDangXuLy();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDenHoanThanh) {
        setState(() {
          screenView= const VBDenHoanThanh();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDenDaVaoSo) {
        setState(() {
          screenView= const VBDenDaVaoSo();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDenTatCa) {
        setState(() {
          screenView= const VBDenTatCa();
        });
      }
      //VAN BAN DI
      else if (drawerIndex == DrawerIndex.VanBanDiGiaoXuLy) {
        setState(() {
          screenView= const VBDiChoGiaoXuLy();
        });
      }
      else if (drawerIndex == DrawerIndex.VanBanDiChuaXuLy) {
        setState(() {
          screenView= const VBDiChuaXuLy();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDiDangXuLy) {
        setState(() {
          screenView= const VBDiDangXuLy();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDiHoanThanh) {
        setState(() {
          screenView= const VBDiHoanThanh();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDiDaVaoSo) {
        setState(() {
          screenView= const VBDiDaVaoSo();
        });
      }else if (drawerIndex == DrawerIndex.VanBanDiTatCa) {
        setState(() {
          screenView= const VBDiTatCa();
        });
      }
      else if (drawerIndex == DrawerIndex.QLMeeting) {
        setState(() {
          screenView= const QLMeeting();
        });
      }
      else if (drawerIndex == DrawerIndex.ThuDaNhan) {
        setState(() {
          screenView= const ThuDaNhan();
        });
      }
      else if (drawerIndex == DrawerIndex.ThuDaGui) {
        setState(() {
          screenView= const ThuDaGui();
        });
      }
      else if (drawerIndex == DrawerIndex.ThuDangSoan) {
        setState(() {
          screenView= const ThuDangSoan();
        });
      }
      else if (drawerIndex == DrawerIndex.ThungRacDaGui) {
        setState(() {
          screenView= const ThungRacThuDaGui();
        });
      }
      else if (drawerIndex == DrawerIndex.ThungRacDaNhan) {
        setState(() {
          screenView= const ThungRacThuDaNhan();
        });
      }else if (drawerIndex == DrawerIndex.DocThongBao) {
        setState(() {
          screenView= const DocThongBao();
        });
      }else if (drawerIndex == DrawerIndex.QLThongBao) {
        setState(() {
          screenView= const QLThongBao();
        });
      }else if (drawerIndex == DrawerIndex.QLMeeting) {
        setState(() {
          screenView= const QLMeeting();
        });
      }else if (drawerIndex == DrawerIndex.LichCongTac) {
        setState(() {
          screenView= const LichCongTac();
        });
      }else if (drawerIndex == DrawerIndex.LichDonVi) {
        setState(() {
          screenView= const LichDonVi();
        });
      }else if (drawerIndex == DrawerIndex.LichCaNhan) {
        setState(() {
          screenView= const LichCaNhan();
        });
      }else if (drawerIndex == DrawerIndex.QLKeHoach) {
        setState(() {
          screenView= const QLKeHoach();
        });
      }
      else if (drawerIndex == DrawerIndex.MauVanBan) {
        setState(() {
          screenView= const QLMauVanBan();
        });
      }
      else if (drawerIndex == DrawerIndex.VanBanPhapQuy) {
        setState(() {
          screenView= const QLVanBanPhapQuy();
        });
      }
      else if (drawerIndex == DrawerIndex.DatPhongTheoDoiDatLich) {
        setState(() {
          screenView= const DatPhongDuyetYeuCau();
        });
      }
      else if (drawerIndex == DrawerIndex.DatPhongSapXepLich) {
        setState(() {
          screenView= const DatPhongTheoDoiYeuCau();
        });
      }
      else if (drawerIndex == DrawerIndex.DatPhongKetQuaXepLichPhong) {
        setState(() {
          screenView= const DatPhongXemKetQua();
        });
      }
      else if (drawerIndex == DrawerIndex.DatXeDuyetYeuCau) {
        setState(() {
          screenView= const VPPDuyetYeuCau();
        });
      }
      else if (drawerIndex == DrawerIndex.DatXeTheoDoiYeuCau) {
        setState(() {
          screenView= const VPPTheoDoiYeuCau();
        });
      }
      else if (drawerIndex == DrawerIndex.DatXeXemKetQuaDuyet) {
        setState(() {
          screenView= const VPPXemKetQua();
        });
      }
      else if (drawerIndex == DrawerIndex.HoSoCaNhan) {
        setState(() {
          screenView= const QLHoSoCaNhan();
        });
      }
      else if (drawerIndex == DrawerIndex.HoSoDonVi) {
        setState(() {
          screenView= const QLHoSoDonVi();
        });
      }
      else if (drawerIndex == DrawerIndex.InforAccount) {
        setState(() {
          screenView = const InfoAccount();
        });
      } else {
        //do in your way......
      }
    }
  }
}
