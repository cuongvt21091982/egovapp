
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/vpp/dangkyhop.dart';
import 'package:egovapp/page/datphong/xuly/app-xuly-datphong.dart';
import 'package:egovapp/page/datphong/xuly/approved.dart';
import 'package:egovapp/service/vpp/service-dangkyhop.dart';
import 'package:flutter/material.dart';
class DangKyDatPhongDetailApproved extends StatefulWidget
{
  const DangKyDatPhongDetailApproved({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _DangKyDatPhongDetailApprovedState createState() => _DangKyDatPhongDetailApprovedState();
}
class _DangKyDatPhongDetailApprovedState extends State<DangKyDatPhongDetailApproved>
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
        future: ServiceDangKyHop().getById(this.widget.id).catchError((onError){
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
                DangKyHop _dangKy = snapshot.data;
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
                                    UIUtils.setNameDanhMuc(Language.getText('phong')+': '+_dangKy.phong.tenPhong)
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
                        if(_dangKy.trangThai == ParamUtils.statusSuccess)
                          Container(padding: UIUtils.paddingListView,
                              child: UIUtils.setTextBoldTitle(Language.getText("noidungpheduyet"))
                          ),
                        if(_dangKy.trangThai == ParamUtils.statusSuccess)
                          Container(
                              child:
                              SingleChildScrollView(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        UIUtils.setHtmlItem(_dangKy.pheDuyet)
                                      ]
                                  )
                              )

                          ),
                        if(_dangKy.trangThai == ParamUtils.statusChuaXuLy || _dangKy.trangThai == ParamUtils.statusDangXuLy)
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: UIUtils.paddingLite,
                                      child:
                                      TextButton.icon(onPressed: () async {
                                        Navigator.push(context, new MaterialPageRoute(builder: (context) => new PheDuyetDangKyDatPhong(id: this.widget.id,
                                            title: Language.getText('ykienpheduyettuchoi'), callBackRefresh: () =>
                                                setState((){ })
                                        )),);
                                      },
                                        style:UIUtils.setButtonConfirmStyle(),
                                        icon: UIUtils.setButtonIcon(Icons.send) ,
                                        label: UIUtils.setButtonResetText(Language.getText("ykienpheduyettuchoi")
                                        ),
                                      )
                                  )
                                ],)
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
          title: Text(Language.getText("thongtinpheduyet")),
          actions: [AppBarDangKyDatPhongXuLyAction(id: this.widget.id, title: this.chuDe,
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
