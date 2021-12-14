import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/calendar/calendardepartcomment.dart';
import 'package:egovapp/service/calendar/service-calendardepartcomment.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class CalendarDepartYKienTongHopDialog extends StatefulWidget
{
  const  CalendarDepartYKienTongHopDialog({Key? key, required this.id,
    required this.year,required this.title}) : super(key: key);
  final int id;
  final int year;
  final String title;
  @override
  _CalendarDepartYKienTongHopDialogState createState() => _CalendarDepartYKienTongHopDialogState();
}
class _CalendarDepartYKienTongHopDialogState extends State<CalendarDepartYKienTongHopDialog> {

  String title = Language.getText('thongtinxuly');
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  final PagingController<int,CalendarDepartComment> _pagingController = PagingController(firstPageKey: 0);
  @override

  Future<void> _fetchPage(int pageKey) async {
    ServiceCalendarDepartComment().getPaging(this.widget.id, this.widget.year, UserAuthSession.unitId, page, size).then((value)
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
    var contentPage=PagedListView<int, CalendarDepartComment>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CalendarDepartComment>(
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
                          UIUtils.setTextHeaderCommentItem(item.staffs.fullName)

                        ]),
                    Row( children:[
                      UIUtils.getIconLevel(),
                      UIUtils.setDescriptionLevel(item.staffs.chucVuItem.tenChucVu + ' - '+ item.staffs.donViItem.tenCQ)
                    ]
                    )
                  ],
                ) ,
                isThreeLine: true
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