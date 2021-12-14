import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/vanbandi/vanbandi.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/vanbandi/xuly/app-vanbandi-xuly.dart';
import 'package:egovapp/page/vanbandi/xuly/ykien.dart';
import 'package:egovapp/service/vanbandi/service-vanbandi.dart';
import 'package:egovapp/service/vanbandi/service-vanbandifile.dart';
import 'package:egovapp/service/vanbandi/service-vanbandixuly.dart';
import 'package:flutter/material.dart';
class VanBanDiDetail extends StatefulWidget
{
  const VanBanDiDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _VanBanDiDetailState createState() => _VanBanDiDetailState();
}
class _VanBanDiDetailState extends State<VanBanDiDetail>
{
  String chuDe = '';
  int trangThai = 0;
  int maNguoiChuTri = 0;
  int trangThaiXuLy = 0;
  String ketQuaXuLyNguoiChuTri="";
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;
    ServiceVanBanDiXuLy().getByMaVBAndMaXL(this.widget.id, UserAuthSession.staffId).then((value) {
      trangThaiXuLy = value.maTrangThaiXL;
      ServiceVanBanDiXuLy().getByMaVBAndMaXL(this.widget.id, value.maNguoiChuTri).then((value2){
        ketQuaXuLyNguoiChuTri = value2.ketQua;
      })..catchError((e2){
        UIUtils.showToastError(e2.toString(), context);
      });

    })..catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  void yKienXuLy()
  {
    if((trangThaiXuLy != ParamUtils.statusHoanThanh || maNguoiChuTri == UserAuthSession.staffId) && trangThai != ParamUtils.statusHoanThanh) {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                YKienVanBanDi(
                    id: this.widget.id, title: Language.getText('ykienxuly')),
            fullscreenDialog: true,
          ));
    }else
    {
      UIUtils.showToastWarning(Language.getText('alert_yeucau_success') , context);
    }
  }
  @override
  Widget build(BuildContext context) {
    var futureContent= FutureBuilder(
        future: ServiceVanBanDi().getById(this.widget.id).catchError((onError){
          UIUtils.showToastError(onError.toString(), context);
        }),
        builder: (context ,AsyncSnapshot  snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: UIUtils.progressLoad());
            default:
              if (snapshot.hasData == false)
                return Center(child: UIUtils.progressLoad());
              else {
                VanBanDi _vanBanDi = snapshot.data;
                this.trangThai = _vanBanDi.maTrangThaiXL;
                this.maNguoiChuTri = _vanBanDi.maNguoiChuTri;
                return ListTile( minLeadingWidth: 0,
                    contentPadding:UIUtils.paddingLite,
                    subtitle:
                    ListView(
                      children: [
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconPerson(),
                                    UIUtils.setNamePerson(Language.getText('nguoichutri')+': '+_vanBanDi.nguoiChuTri.fullName)
                                  ]
                                  )

                                ]
                            )
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconSo(),
                                    UIUtils.setNameDate(Language.getText('sovaoso')+': ' + _vanBanDi.soVaoSo)

                                  ]),

                                ]
                            )
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconDate(),
                                    UIUtils.setNameDate(Language.getText('ngayvaoso')+': ' + _vanBanDi.ngayVaoSo)

                                  ]),

                                ]
                            )
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconDate(),
                                    UIUtils.setNameDate(Language.getText('ngayky')+': ' + _vanBanDi.ngayKy)

                                  ]),

                                ]
                            )
                        ),
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconPerson(),
                                    UIUtils.setNamePerson(Language.getText('nguoiky')+': '+_vanBanDi.nguoiKy.fullName)
                                  ]
                                  )

                                ]
                            )
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconDate(),
                                    UIUtils.setNameDate(Language.getText('thoihan')+': '+_vanBanDi.thoiHan)
                                  ])

                                ]
                            )
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconStatus(_vanBanDi.maTrangThaiXL),
                                    UIUtils.getTextStatus(_vanBanDi.maTrangThaiXL)
                                  ])

                                ]
                            )
                        ),
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(
                                children: [
                                  TextButton.icon(onPressed: () async {
                                    ServiceVanBanDiFile().getAllByVanBanId(this.widget.id).then((value)
                                    {
                                      List<FileLink> fileLinks=[];
                                      for(var item in value)
                                      {
                                        fileLinks.add(new FileLink(name: item.name,
                                            link: ApiUtils().getDownloadFileUrl(item.folder, item.fileKey, item.width, item.name)));
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                DonwloadFileDialog( files: fileLinks),
                                            fullscreenDialog: true,
                                          ));
                                    });
                                  },
                                      style:UIUtils.setButtonAttachViewStyle(),
                                      icon: UIUtils.setButtonIcon(Icons.attach_file),
                                      label: UIUtils.setButtonText(Language.getText("xemvanban")
                                      )
                                  )
                                ]
                            )

                        ) ,
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("butphelanhdao"))
                        ),
                        Container(padding: UIUtils.paddingListView,
                            decoration:UIUtils.setBorderBox(),
                            child: SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setTextContent(_vanBanDi.noiDungXL)
                                    ]
                                )
                            )

                        ),
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("ketquaxulynguoichutri"))
                        ),
                        Container(
                            padding: UIUtils.paddingLiteSubTitle,
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(ketQuaXuLyNguoiChuTri)
                                    ]
                                )
                            )

                        )
                      ],
                    ),
                    title:
                    Row(children: [
                      UIUtils.setTextHeaderDetailItem(_vanBanDi.trichYeu)
                    ])
                );
              }
          }

        });
    return  new WillPopScope(
      onWillPop: () {
        this.widget.callBackRefresh();
        return new Future.value(true);
      },
      child:  Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title: Text(Language.getText("xulyvanbandi")),
          actions: [AppBarVanBanDiXuLyAction(id: this.widget.id, title: this.chuDe,
              callBackRefresh: () =>
                  setState(() {
                    this.widget.callBackRefresh();
                  })
          )],
        ),

        body: futureContent,
        floatingActionButton: FloatingActionButton(
          onPressed: yKienXuLy,
          tooltip: Language.getText('ykienxuly') ,
          child: Icon(Icons.edit_location_alt),
        ),
        bottomNavigationBar: BottomBarAction(),
        // This trailing comma makes auto-formatting nicer for build methods.
      ) ,
    );

  }


}
