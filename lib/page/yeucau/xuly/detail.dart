import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/yeucau/yeucau.dart';
import 'package:egovapp/page/yeucau/xuly/apb-yeucau-xuly.dart';
import 'package:egovapp/service/yeucau/service-yeucau.dart';
import 'package:egovapp/service/yeucau/service-yeucauxuly.dart';
import 'ykien.dart';
import 'package:flutter/material.dart';
class YeuCauDetail extends StatefulWidget
{
  const YeuCauDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _YeuCauDetailState createState() => _YeuCauDetailState();
}
class _YeuCauDetailState extends State<YeuCauDetail>
{
  String chuDe = '';
  int trangThai = 0;
  int maNguoiChuTri = 0;
  int trangThaiXuLy = 0;
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;
    ServiceYeuCauXuLy().getByMaVBAndMaXL(this.widget.id, UserAuthSession.staffId).then((value) {
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
            builder: (BuildContext context) =>
                YKienYeuCau(
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
        future: ServiceYeuCau().getById(this.widget.id).catchError((onError){
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
                YeuCau _yeuCau = snapshot.data;
                this.trangThai = _yeuCau.trangThai;
                this.maNguoiChuTri = _yeuCau.maNguoiChuTri;
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
                                    UIUtils.setNamePerson(Language.getText('nguoichutri')+': '+_yeuCau.nguoiChuTri.fullName)
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
                                    UIUtils.setNameDate(Language.getText('thoigiangui')+': '+_yeuCau.thoiGianGui)

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
                                    UIUtils.setNameDate(Language.getText('thoigianhoanthanh')+': '+_yeuCau.thoiGianHoanThanh)
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
                                    UIUtils.getIconStatus(_yeuCau.trangThai),
                                    UIUtils.getTextStatus(_yeuCau.trangThai)
                                  ])

                                ]
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
                                      UIUtils.setHtmlContentItem(_yeuCau.ketQua)
                                    ]
                                )
                            )

                        ) ,
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(_yeuCau.noiDung)
                                    ]
                                )
                            )

                        )
                      ],
                    ),
                    title:
                    Row(children: [
                      UIUtils.setTextHeaderDetailItem(_yeuCau.chuDe)
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
          title: Text(Language.getText("xulyyeucau")),
          actions: [AppBarYeuCauXuLyAction(id: this.widget.id, title: this.chuDe,
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
