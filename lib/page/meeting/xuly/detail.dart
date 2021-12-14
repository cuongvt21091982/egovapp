import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/meeting/meeting.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/meeting/xuly/app-meeting-xuly.dart';
import 'package:egovapp/service/meeting/service-meeting.dart';
import 'package:egovapp/service/meeting/service-meetingfile.dart';
import 'package:egovapp/service/meeting/service-meetingxuly.dart';
import 'ykien.dart';
import 'package:flutter/material.dart';
class MeetingDetail extends StatefulWidget
{
  const MeetingDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _MeetingDetailState createState() => _MeetingDetailState();
}
class _MeetingDetailState extends State<MeetingDetail>
{
  String chuDe = '';
  int trangThai = 0;
  int maNguoiChuTri = 0;
  int trangThaiXuLy = 0;
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;
    ServiceMeetingXuLy().getByMaVBAndMaXL(this.widget.id, UserAuthSession.staffId).then((value) {
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
                YKienMeeting(
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
        future: ServiceMeeting().getById(this.widget.id).catchError((onError){
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
                Meeting _meeting = snapshot.data;
                this.trangThai = _meeting.trangThai;
                this.maNguoiChuTri = _meeting.maNguoiChuTri;
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
                                    UIUtils.setNamePerson(Language.getText('nguoichutri')+': '+_meeting.nguoiChuTri.fullName)
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
                                    UIUtils.setNameDate(Language.getText('thoigiangui')+': '+_meeting.thoiGianGui)

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
                                    UIUtils.setNameDate(Language.getText('thoihan')+': '+_meeting.thoiGianHoanThanh)
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
                                    UIUtils.getIconStatus(_meeting.trangThai),
                                    UIUtils.getTextStatus(_meeting.trangThai)
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
                                    ServiceMeetingFile().getAllByMeetingId(this.widget.id).then((value)
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
                            child: UIUtils.setTextBoldTitle(Language.getText("ketquaxulynguoichutri"))
                        ),
                        Container(
                            padding: UIUtils.paddingLiteSubTitle,
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(_meeting.ketQua)
                                    ]
                                )
                            )

                        ) ,
                        Container(
                            child:
                            SingleChildScrollView(
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      UIUtils.setHtmlContentItem(_meeting.noiDung)
                                    ]
                                )
                            )

                        )
                      ],
                    ),
                    title: UIUtils.setTextHeaderDetailItem(_meeting.chuDe)

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
          title: Text(Language.getText("thongtincuochop")),
          actions: [AppBarMeetingXuLyAction(id: this.widget.id, title: this.chuDe,
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
