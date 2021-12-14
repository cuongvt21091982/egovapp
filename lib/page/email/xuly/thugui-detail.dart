import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/email/thu.dart';
import 'package:egovapp/model/email/thufile.dart';
import 'package:egovapp/model/email/thutemp.dart';
import 'package:egovapp/page/email/xuly/app-email-xuly-thugui.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/service/email/service-thutemp.dart';
import 'package:flutter/material.dart';
class ThuGuiDetail extends StatefulWidget
{
  const ThuGuiDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;

  _ThuGuiDetailState createState() => _ThuGuiDetailState();
}
class _ThuGuiDetailState extends State<ThuGuiDetail>
{
  String chuDe = '';
  String nguoiNhan='';
  List<Thu> thuNhoms=[];
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;

  }
  void showFile(List<ThuFile> value)
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

  }
  @override
  Widget build(BuildContext context) {
    var futureContent= FutureBuilder(
        future: ServiceThuTemp().getById(this.widget.id).catchError((onError){
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
                ThuTemp _thuTemp = snapshot.data;

                return
                  Column(
                    children: [
                      Container(padding: UIUtils.paddingListView,
                          alignment: Alignment.topLeft,
                          child: UIUtils.setTextHeaderDetailItem(_thuTemp.vanDe)
                      ),
                      Container(padding: UIUtils.paddingListView,
                          child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row( children:[
                                  UIUtils.getIconPerson(),
                                  UIUtils.setNamePerson(Language.getText("nguoigui")+": "+_thuTemp.nguoiTaoItem.fullName)

                                ])
                              ]
                          )
                      ),
                      Container(padding: UIUtils.paddingListView,
                          child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row( children:[
                                  UIUtils.getIconDate(),
                                  UIUtils.setNameDate(Language.getText('thoigiangui')+': '+_thuTemp.ngayTao)

                                ]),

                              ]
                          )
                      ),
                      Container(padding: UIUtils.paddingListView,
                          alignment: Alignment.topLeft,
                          child: UIUtils.setTextBoldTitle(Language.getText("nguoinhan"))
                      ),
                      Container(padding: UIUtils.paddingListView,
                          alignment: Alignment.topLeft,
                          child:  UIUtils.setNamePersonReceive(_thuTemp.nguoinhanTen)
                      ),
                      if(_thuTemp.thuFiles.length>0)
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(
                                children: [
                                  TextButton.icon(onPressed: () async {

                                      List<FileLink> fileLinks=[];
                                      for(var item in _thuTemp.thuFiles)
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

                                  },
                                      style:UIUtils.setButtonAttachViewStyle(),
                                      icon: UIUtils.setButtonIcon(Icons.attach_file),
                                      label: UIUtils.setButtonText(Language.getText("xemfiledinhkem")
                                      )
                                  )
                                ]
                            )

                        )
                      ,
                      Container(padding: UIUtils.paddingListView,
                          alignment: Alignment.topLeft,
                          child: UIUtils.setTextBoldTitle(Language.getText("noidung"))
                      ),
                      Container(
                          child:UIUtils.setHtmlItem(_thuTemp.noiDung)

                      )

                    ],
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
          title: Text(Language.getText("thongtinthugui")),
          actions: [AppBarEmailXuLyThuGuiAction(id: this.widget.id, title: this.chuDe,
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
