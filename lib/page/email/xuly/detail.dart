import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/email/thu.dart';
import 'package:egovapp/model/email/thufile.dart';
import 'package:egovapp/page/email/xuly/app-email-xuly.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:egovapp/service/email/service-thufile.dart';
import 'package:egovapp/service/email/service-thutemp.dart';
import 'package:flutter/material.dart';
class ThuDetail extends StatefulWidget
{
  const ThuDetail({Key? key, required this.id,
    required this.chuDe,
    required this.callBackRefresh
  }) : super(key: key);
  final int id;
  final VoidCallback callBackRefresh;
  final String chuDe;
  @override
  _ThuDetailState createState() => _ThuDetailState();
}
class _ThuDetailState extends State<ThuDetail>
{
  String chuDe = '';
  String nguoiNhan='';
  List<Thu> thuNhoms=[];
  @override
  void initState(){
    super.initState();
    this.chuDe = this.widget.chuDe;

      ServiceThu().getByReadId(this.widget.id).then((value) {
            ServiceThuTemp().getById(value.nhomThu).then((value2){
              nguoiNhan=value2.nguoinhanTen;
            })..catchError((onError){
              UIUtils.showToastError(onError.toString(), context);
            });

            ServiceThu().getAllByNhomThu(value.id, UserAuthSession.staffId).then((value3){
              setState(() {
                thuNhoms = value3;
              });
            })..catchError((onError){

              UIUtils.showToastError(onError.toString(), context);
            });
      })..catchError((onError){
        UIUtils.showToastError(onError.toString(), context);
      });

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
        future: ServiceThu().getById(this.widget.id).catchError((onError){
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
                Thu _thu = snapshot.data;
                return
                    Column(
                      children: [
                        Container(padding: UIUtils.paddingListView,
                          alignment: Alignment.topLeft,
                          child: UIUtils.setTextHeaderDetailItem(_thu.vanDe)
                        ),
                        Container(padding: UIUtils.paddingListView,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row( children:[
                                    UIUtils.getIconPerson(),
                                    UIUtils.setNamePerson(Language.getText("nguoigui")+": "+_thu.nguoiGui.fullName)

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
                                    UIUtils.setNameDate(Language.getText('thoigiangui')+': '+_thu.ngayTao)

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
                            child:  UIUtils.setNamePersonReceive(nguoiNhan)
                        ),
                        if(_thu.thuFiles.length>0)
                        Container(
                            padding: UIUtils.paddingListView,
                            child:
                            Row(
                                children: [
                                  TextButton.icon(onPressed: () async {
                                    ServiceThuFile().getAllByThuId(this.widget.id).then((value)
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

                        )
                        ,
                        Container(
                            child: Expanded(
                              flex: 100,
                              child:
                                ListView.builder(

                                    padding: const EdgeInsets.all(8),
                                    itemCount: thuNhoms.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile( minLeadingWidth: 0,
                                          contentPadding:UIUtils.paddingLite,
                                          subtitle:
                                          Container(
                                              decoration: UIUtils.setBorderBox(),
                                              child:UIUtils.setHtmlItem(thuNhoms[index].noiDung)

                                          ),
                                          title:
                                              Column(
                                                children: [
                                                  Container(
                                                    padding: UIUtils.paddingListView,
                                                    alignment: Alignment.topLeft,
                                                    child: UIUtils.setNamePerson(thuNhoms[index].nguoiGui.fullName),
                                                  ),
                                                  Container(
                                                    padding: UIUtils.paddingListView,
                                                    alignment: Alignment.topLeft,
                                                    child:  UIUtils.setNameDate(Language.getText('phanhoi')+': '+thuNhoms[index].ngayTao),
                                                  ),
                                                  if(thuNhoms[index].thuFiles.length>0)
                                                  Container(
                                                      alignment: Alignment.topLeft,
                                                    child:TextButton.icon(onPressed: () async {
                                                      showFile(thuNhoms[index].thuFiles);
                                                    },
                                                        style:UIUtils.setNoButtonAttachViewStyle(),
                                                        icon: UIUtils.setNoButtonIcon(Icons.attach_file),
                                                        label: UIUtils.setNoButtonText(thuNhoms[index].thuFiles.length.toString()+" "+ Language.getText("filedinhkem")
                                                        )
                                                    )
                                                  )



                                                ],
                                              ),
                                          leading: UIUtils.setCircleAvatarStatusItem(thuNhoms[index].nguoiGui.ten, thuNhoms[index].checkread == ParamUtils.statusOFF? ParamUtils.statusChuaXuLy: ParamUtils.statusDangXuLy)
                                      );
                                    }
                                )
                              ,
                            )

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
          title: Text(Language.getText("thongtinthu")),
          actions: [AppBarEmailXuLyAction(id: this.widget.id, title: this.chuDe,
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
