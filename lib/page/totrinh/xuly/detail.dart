import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/service/totrinh/service-totrinhfile.dart';
import 'package:egovapp/service/totrinh/service-totrinhxuly.dart';
import 'apb-totrinh-xuly.dart';
import 'ykien.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:flutter/material.dart';
class ToTrinhDetail extends StatefulWidget
{
  const ToTrinhDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
   }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _ToTrinhDetailState createState() => _ToTrinhDetailState();
}
class _ToTrinhDetailState extends State<ToTrinhDetail>
{
  String chuDe = '';
  int trangThai = 0;
  int maNguoiChuTri = 0;
  int trangThaiXuLy = 0;
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;
    ServiceToTrinhXuLy().getByMaVBAndMaXL(this.widget.id, UserAuthSession.staffId).then((value) {
      trangThaiXuLy = value.trangThai;
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
          builder: (BuildContext context) => YKienToTrinh(id: this.widget.id, title: Language.getText('ykienxuly')),
          fullscreenDialog: true,
        )); }else
    {
      UIUtils.showToastWarning(Language.getText('alert_totrinh_success') , context);
    }
  }
  @override
  Widget build(BuildContext context) {
    var futureContent= FutureBuilder(
        future: ServiceToTrinh().getById(this.widget.id).catchError((onError){
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
                  ToTrinh _toTrinh = snapshot.data;
                  this.trangThai = _toTrinh.trangThai;
                  this.maNguoiChuTri = _toTrinh.maNguoiChuTri;
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
                                      UIUtils.setNamePerson(Language.getText('nguoitrinh')+': '+_toTrinh.nguoiTrinh.fullName)
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
                                      UIUtils.setNameDate(Language.getText('thoigiangui')+': '+_toTrinh.thoiGianGui)

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
                                      UIUtils.setNameDate(Language.getText('thoigianhoanthanh')+': '+_toTrinh.thoiGianHoanThanh)
                                    ])

                                  ]
                              )
                          )
                          ,
                          Container(padding: UIUtils.paddingListView,
                              child:
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row( children:[
                                      UIUtils.getIconStatus(_toTrinh.trangThai),
                                      UIUtils.getTextStatus(_toTrinh.trangThai)
                                    ])

                                  ]
                              )
                          ),Container(
                              padding: UIUtils.paddingListView,
                              child:
                              Row(
                                  children: [
                                    TextButton.icon(onPressed: () async {
                                      ServiceToTrinhFile().getAllByToTrinhId(this.widget.id).then((value)
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
                                        label: UIUtils.setButtonText(Language.getText("xemtotrinh")
                                        )
                                    )
                                  ]
                              )

                          ),
                          Container(padding: UIUtils.paddingListView,
                              child: UIUtils.setTextBoldTitle(Language.getText("ketquaxulynguoichutri"))
                          ),
                          Container(
                              child:
                              SingleChildScrollView(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        UIUtils.setHtmlContentItem(_toTrinh.ketQua)
                                      ]
                                  )
                              )

                          ) ,
                          Container(padding: UIUtils.paddingListView,
                              child: UIUtils.setTextBoldTitle(Language.getText("noidung"))
                          ),
                          Container(
                              padding: UIUtils.paddingLiteSubTitle,
                              child:
                              SingleChildScrollView(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        UIUtils.setHtmlContentItem(_toTrinh.noiDung)
                                      ]
                                  )
                              )

                          )
                        ],
                      ),
                      title:
                      Row(children: [
                        UIUtils.setTextHeaderDetailItem(_toTrinh.chuDe)
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
            title: Text(Language.getText("xulytotrinh")),
            actions: [AppBarToTrinhXuLyAction(id: this.widget.id, title: this.chuDe,
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
