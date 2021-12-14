
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/vpp/dangky.dart';
import 'package:egovapp/page/vpp/xuly/app-xuly-vpp.dart';
import 'package:egovapp/service/vpp/service-dangky.dart';
import 'package:flutter/material.dart';
class DangKyDetail extends StatefulWidget
{
  const DangKyDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _DangKyDetailState createState() => _DangKyDetailState();
}
class _DangKyDetailState extends State<DangKyDetail>
{
  String chuDe = '';
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;
  }

  @override
  Widget build(BuildContext context) {
    var futureContent= FutureBuilder(
        future: ServiceDangKy().getById(this.widget.id).catchError((onError){
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
                DangKy _dangKy = snapshot.data;
                return ListTile( minLeadingWidth: 0,
                    contentPadding:UIUtils.paddingLite,
                    subtitle:
                    ListView(
                      children: [
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconRead(),
                                    UIUtils.setNameDanhMuc(Language.getText('nguoichutri')+': '+_dangKy.nguoiChuTri)

                                  ]),
                                  Row( children:[
                                    UIUtils.getIconDate(),
                                    UIUtils.setNameDanhMuc(Language.getText('thoigian')+': '+_dangKy.ngay+' '+_dangKy.thoiGian)

                                  ]),
                                  Row( children:[
                                    UIUtils.getIconDate(),
                                    UIUtils.setNameDanhMuc(Language.getText('thietbi')+': '+_dangKy.thietBi.tenThietBi)
                                  ])

                                ]
                            )
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.getTextStatusApproved(_dangKy.trangThai)
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("ghichu"))
                        ),
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setTextContent(_dangKy.ghiChu)
                                    ]
                                )
                            )

                        ),
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("yeucautraloi"))
                        ),
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlItem(_dangKy.yeuCauTraLoi)
                                    ]
                                )
                            )

                        ),
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("noidungpheduyet"))
                        ),
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlItem(_dangKy.pheDuyet)
                                    ]
                                )
                            )

                        )

                      ],
                    ),
                    title:
                    Row(children: [
                      UIUtils.setTextHeaderDetailItem(_dangKy.noiDung)
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
          title: Text(Language.getText("thongtindangky")),
          actions: [AppBarDangKyVPPXuLyAction(id: this.widget.id, title: this.chuDe,
              callBackRefresh: () =>
                  setState(() {
                    this.widget.callBackRefresh();
                  })
          )],
        ),

        body: futureContent,
        bottomNavigationBar: BottomBarAction(),
        // This trailing comma makes auto-formatting nicer for build methods.
      ) ,
    );

  }


}
