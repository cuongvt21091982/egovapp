import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import '../xuly/apb-totrinh-xuly.dart';
import '../xuly/ykien.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:flutter/material.dart';
class ToTrinhXuLyDetail extends StatefulWidget
{
  const ToTrinhXuLyDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _TToTrinhXuLyDetailState createState() => _TToTrinhXuLyDetailState();
}
class _TToTrinhXuLyDetailState extends State<ToTrinhXuLyDetail>
{
  String chuDe = '';
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
          builder: (BuildContext context) => YKienToTrinh(id: this.widget.id, title: Language.getText('ykienxuly')),
          fullscreenDialog: true,
        ));
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
                        ) ,
                        Container(
                            padding: UIUtils.paddingLiteSubTitle,
                            child:
                            SingleChildScrollView(
                                padding:  EdgeInsets.fromLTRB(0,0,0,30),
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
          //title: Text(widget.title),
          actions: [AppBarToTrinhXuLyAction(id: this.widget.id, title: this.chuDe,
              callBackRefresh: () =>
                  setState(() {

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
