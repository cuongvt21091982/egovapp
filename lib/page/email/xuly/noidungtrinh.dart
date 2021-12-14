import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/model/email/thufile.dart';
import 'package:egovapp/model/email/thutemp.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:egovapp/service/email/service-thutemp.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ThuNoiDungTrinh extends StatefulWidget
{
  const  ThuNoiDungTrinh({Key? key, required this.id, required this.title}) : super(key: key);
  final int id;
  final String title;

  @override
  _ThuNoiDungTrinhState createState() => _ThuNoiDungTrinhState();
}
class _ThuNoiDungTrinhState extends State<ThuNoiDungTrinh> {
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  String noiDung='';
  int thuGocId=0;
  final PagingController<int,ThuTemp> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceThuTemp().findAllByThuGoc(thuGocId).then((value)
    {
      try {
        final isLastPage = value.length < size;
        if (isLastPage) {
          _pagingController.appendLastPage(value);
        } else {
          page +=1;
          final nextPageKey = pageKey + value.length;
          _pagingController.appendPage(value, nextPageKey);
        } } catch (error) {
        _pagingController.error = error;
      }
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  @override
  void initState() {

    super.initState();
    ServiceThu().getById(this.widget.id).then((value) {
      this.noiDung = value.noiDung;
      setState(() {
        this.thuGocId = value.thuGoc;
      });
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
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
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    var contentPage=PagedListView<int, ThuTemp>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ThuTemp>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>   ListTile( minLeadingWidth: 0,
                contentPadding:UIUtils.paddingLite,
                subtitle:
                Container(
                    decoration: UIUtils.setBorderBox(),
                    child:UIUtils.setHtmlItem(item.noiDung)

                ),
                title:
                Column(
                  children: [
                    Container(
                      padding: UIUtils.paddingListView,
                      alignment: Alignment.topLeft,
                      child: UIUtils.setNamePerson(item.nguoiTaoItem.fullName),
                    ),
                    Container(
                      padding: UIUtils.paddingListView,
                      alignment: Alignment.topLeft,
                      child:  UIUtils.setNameDate(Language.getText('phanhoi')+': '+item.ngayTao),
                    ),
                    if(item.thuFiles.length>0)
                      Container(
                          alignment: Alignment.topLeft,
                          child:TextButton.icon(onPressed: () async {
                            showFile(item.thuFiles);
                          },
                              style:UIUtils.setNoButtonAttachViewStyle(),
                              icon: UIUtils.setNoButtonIcon(Icons.attach_file),
                              label: UIUtils.setNoButtonText(item.thuFiles.length.toString()+" "+ Language.getText("filedinhkem")
                              )
                          )
                      )



                  ],
                ),
                leading: UIUtils.setCircleAvatarStatusItem(item.nguoiTaoItem.ten, item.checkread == ParamUtils.statusOFF? ParamUtils.statusChuaXuLy: ParamUtils.statusDangXuLy)
            )
        )
    );
    var bodyPage=Column(children: [
      Container(
          padding: UIUtils.paddingLiteSubTitle,
          child:
          SingleChildScrollView(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    UIUtils.setHtmlContentItem(noiDung)
                  ]
              )
          )

      ),
      contentPage

    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIUtils.colorDialog,
        title: Text(this.widget.title),
      ),
      body: bodyPage,
    );
  }
}