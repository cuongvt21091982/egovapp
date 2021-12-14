import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/kehoach/kehoach.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/kehoach/xuly/app-kehoach-xuly.dart';
import 'package:egovapp/page/meeting/xuly/app-meeting-xuly.dart';
import 'package:egovapp/service/kehoach/service-kehoach.dart';
import 'package:egovapp/service/kehoach/service-kehoachfile.dart';
import 'package:egovapp/service/thongbao/service-thongbao.dart';
import 'package:flutter/material.dart';
class KeHoachDetail extends StatefulWidget
{
  const KeHoachDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _KeHoachDetailState createState() => _KeHoachDetailState();
}
class _KeHoachDetailState extends State<KeHoachDetail>
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
        future: ServiceKeHoach().getById(this.widget.id).catchError((onError){
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
                KeHoach _keHoach = snapshot.data;
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
                                    UIUtils.setTextLocationTitle(Language.getText('loaikehoach')+': '+_keHoach.loaiKeHoach.tenKeHoach)

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
                                    ServiceKeHoachFile().getAllByKeHoachId(this.widget.id).then((value)
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
                            child: UIUtils.setTextBoldTitle(Language.getText("ghichu"))
                        ),
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(_keHoach.ghiChu)
                                    ]
                                )
                            )

                        )
                        ,
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextBoldTitle(Language.getText("noidung"))
                        ),
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(_keHoach.noiDungKH)
                                    ]
                                )
                            )

                        )
                      ],
                    ),
                    title:
                        Container(child: UIUtils.setTextHeaderDetailItem(_keHoach.tenKH)
                        )
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
          title: Text(Language.getText("thongtinkehoach")),
          actions: [AppBarKeHoachXuLyAction(id: this.widget.id, title: this.chuDe,
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
