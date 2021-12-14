import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/calendar/calendardepart.dart';
import 'package:egovapp/page/calendar/donvi/app-donvi-xuly.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/service/calendar/service-calendardepart.dart';
import 'package:egovapp/service/calendar/service-calendardepartfile.dart';

import 'package:flutter/material.dart';
class LichDonViDetail extends StatefulWidget
{
  const LichDonViDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;

  @override
  _LichDonViDetailState createState() => _LichDonViDetailState();
}
class _LichDonViDetailState extends State<LichDonViDetail>
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
        future: ServiceCalendarDepart().getById(this.widget.id).catchError((onError){
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
                CalendarDepart _calendarNews = snapshot.data;
                return ListTile( minLeadingWidth: 0,
                    contentPadding:UIUtils.paddingLite,
                    subtitle:
                    ListView(
                      children: [
                        Container(padding: UIUtils.paddingListView,
                            child: UIUtils.setTextLocationTitle(Language.getText('diadiem')+': '+ _calendarNews.diaDiem)

                        ),
                        Container(
                            padding: UIUtils.paddingListView,
                            child:Row( children:[
                              UIUtils.getIconDate(),
                              UIUtils.setNameDate(Language.getText('thoigiantu')+': '+ FormatUtils.convertDateTimeToString(_calendarNews.tuNgay!, _calendarNews.tuGio))

                            ])
                        ),
                        Container(
                            padding: UIUtils.paddingListView,
                            child:Row( children:[
                              Row( children:[
                                UIUtils.getIconDate(),
                                UIUtils.setNameDate(Language.getText('thoigianden')+': '+ FormatUtils.convertDateTimeToString(_calendarNews.denNgay!, _calendarNews.denGio))

                              ])

                            ])
                        )
                        ,
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(
                                children: [
                                  TextButton.icon(onPressed: () async {
                                    ServiceCalendarDepartFile().getAllByCalendarId(this.widget.id).then((value)
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
                            child: UIUtils.setTextLong(_calendarNews.ghiChu)
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
                                      UIUtils.setHtmlContentItem(_calendarNews.noiDung)
                                    ]
                                )
                            )

                        )
                      ],
                    ),
                    title:Container(
                        child: UIUtils.setTextHeaderDetailItem(Language.getText("nguoichutri")+": "+_calendarNews.chuTri)
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
          title: Text(Language.getText("thongtinlichdonvi")),
          actions: [AppBarLichDonViXuLyAction(id: this.widget.id, title: this.chuDe,
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
