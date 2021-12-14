import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/model/hoso/hosocomment.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/service/hoso/service-hosocomment.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class HoSoYKienTongHopDialog extends StatefulWidget
{
  const  HoSoYKienTongHopDialog({Key? key, required this.id, required this.title}) : super(key: key);
  final int id;
  final String title;
  @override
  _HoSoYKienTongHopDialogState createState() => _HoSoYKienTongHopDialogState();
}
class _HoSoYKienTongHopDialogState extends State<HoSoYKienTongHopDialog> {

  String title = Language.getText('thongtinxuly');
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  final PagingController<int,HoSoComment> _pagingController = PagingController(firstPageKey: 0);
  @override

  Future<void> _fetchPage(int pageKey) async {
    ServiceHoSoComment().getPaging(this.widget.id,  page, size).then((value)
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
  Widget build(BuildContext context) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    var contentPage=PagedListView<int, HoSoComment>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<HoSoComment>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>  ListTile(
                minLeadingWidth: 0,
                contentPadding:UIUtils.paddingLite,
                subtitle:
                Container(child:
                Column (
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row( children:[
                              UIUtils.getIconRead(),
                              UIUtils.setDescriptionComment(Language.getText('solandoc')+': '+ item.soLanDoc.toString())
                            ]
                            ),
                            Row( children:[
                              UIUtils.getIconStatus(item.status),
                              UIUtils.getTextStatus( item.status)
                            ]
                            ),
                            Row( children:[
                              UIUtils.getIconDate(),
                              UIUtils.setDescriptionComment( item.created.toString())
                            ]
                            )

                          ]
                      ),
                      Container(
                          padding: UIUtils.paddingLiteSubTitle,
                          child:
                          SingleChildScrollView(
                              padding:  EdgeInsets.fromLTRB(0,0,0,20),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    UIUtils.setHtmlContentItem(item.comment)
                                  ]
                              )
                          )
                      )
                    ]

                ),
                    decoration: UIUtils.setBorderBox()
                ),

                title: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          UIUtils.setTextHeaderCommentItem(item.staffs.fullName),
                          Spacer(),
                          if(item.hoSoFileXuLys.length >0)
                            UIUtils.getIconAttachFile()
                        ]),
                    Row( children:[
                      UIUtils.getIconLevel(),
                      UIUtils.setDescriptionLevel(item.staffs.chucVuItem.tenChucVu + ' - '+ item.staffs.donViItem.tenCQ)
                    ]
                    )
                  ],
                ) ,
                isThreeLine: true,
                onTap: (){
                  List<FileLink> fileLinks=[];
                  for(var f in item.hoSoFileXuLys)
                  {
                    fileLinks.add(new FileLink(name: f.name,
                        link: ApiUtils().getDownloadFileUrl(f.folder, f.fileKey, f.width, f.name)));
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            DonwloadFileDialog( files: fileLinks),
                        fullscreenDialog: true,
                      ));
                }
              //leading: UIUtils.setCircleAvatarStatusItem(item.staffs.ten, item.status),

            )
        )
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIUtils.colorDialog,
        title: Text(this.title),
      ),
      body: contentPage,
    );
  }
}