import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/hoso/hoso.dart';

import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/hoso/donvi/xuly/app-hosodonvi-xuly.dart';
import 'package:egovapp/page/hoso/donvi/xuly/ykien.dart';
import 'package:egovapp/page/meeting/xuly/app-meeting-xuly.dart';
import 'package:egovapp/service/hoso/service-hoso.dart';
import 'package:egovapp/service/hoso/service-hosofile.dart';

import 'package:flutter/material.dart';
class HoSoDonViDetail extends StatefulWidget
{
  const HoSoDonViDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _HoSoDonViDetailState createState() => _HoSoDonViDetailState();
}
class _HoSoDonViDetailState extends State<HoSoDonViDetail>
{
  String chuDe = '';
  int trangThai = 0;
  int maNguoiChuTri = 0;
  int trangThaiXuLy = 0;
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;
  }
  void yKienXuLy()
  {

      Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                YKienHoSo(
                    id: this.widget.id, title: Language.getText('ykienxuly')),
            fullscreenDialog: true,
          ));

  }
  @override
  Widget build(BuildContext context) {
    var futureContent= FutureBuilder(
        future: ServiceHoSo().getById(this.widget.id).catchError((onError){
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
                HoSo _hoSo = snapshot.data;

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
                                    UIUtils.setNamePerson(Language.getText('nguoitao')+': '+_hoSo.nguoiTao.fullName)
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
                                    UIUtils.setNameDate(Language.getText('ngaytao')+': '+_hoSo.ngayTao)

                                  ]),

                                ]
                            )
                        ),
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(
                                children: [
                                  TextButton.icon(onPressed: () async {
                                    ServiceHoSoFile().getAllByHoSoId(this.widget.id).then((value)
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
                                      label: UIUtils.setButtonText(Language.getText("xemfiledinhkem")
                                      )
                                  )
                                ]
                            )

                        ),
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("noidung"))
                        ),
                        Container(
                            padding: UIUtils.paddingLiteSubTitle,
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(_hoSo.quaTrinhXuLy)
                                    ]
                                )
                            )

                        )

                      ],
                    ),
                    title: UIUtils.setTextHeaderDetailItem(_hoSo.tenHoSo)
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
          title: Text(Language.getText("thongtinhoso")),
          actions: [AppBarHoSoXuLyAction(id: this.widget.id, title: this.chuDe,
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
