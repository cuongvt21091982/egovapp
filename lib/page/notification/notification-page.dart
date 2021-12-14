import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/staffs/notification.dart';
import 'package:egovapp/page/calendar/congtac/detail.dart';
import 'package:egovapp/page/calendar/donvi/detail.dart';
import 'package:egovapp/page/email/xuly/detail.dart';
import 'package:egovapp/page/meeting/xuly/detail.dart';
import 'package:egovapp/page/thongbao/xuly/detail.dart';
import 'package:egovapp/page/totrinh/totrinhnhan/xuly.dart';
import 'package:egovapp/page/vanbanden/xuly/detail.dart';
import 'package:egovapp/page/vanbandi/xuly/detail.dart';
import 'package:egovapp/service/staffs/service-notification.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class NotificationPage extends StatefulWidget
{
  const NotificationPage({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  String title=Language.getText("tatcathongbao");
  final PagingController<int,NotificationItem> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceNotification().getPaging(UserAuthSession.staffId,ParamUtils.statusNotification, this.widget.type, page, size).then((value)
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
    switch(this.widget.type)
    {
      case 'TOTRINH':
        this.title =Language.getText("totrinhchuaxuly");
        break;
      case 'THUNHAN':
        this.title =Language.getText("thumoinhan");
        break;
      case 'VBDI':
        this.title =Language.getText("vbdichuaxuly");
        break;
      case 'VBDEN':
        this.title =Language.getText("vbdenchuaxuly");
        break;
      case 'THONGBAO':
        this.title =Language.getText("thongbaomoi");
        break;
      case 'MEETING':
        this.title =Language.getText("cuochopmoi");
        break;
      case 'LICHCONGTAC':
        this.title =Language.getText("lichcongtacmoi");
        break;
      case 'LICHDONVI':
        this.title =Language.getText("lichdonvimoi");
        break;
      case 'YEUCAU':
        this.title =Language.getText("yeucauchuaxuly");
        break;
    }
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  searchNotification()
  {
    this.page = Enviroments.currentPage;
    _pagingController.refresh();
  }
  void showDetail(String type, int id, String title)
  {
      if(type=='TOTRINH')
          {
            Navigator.push(context, new MaterialPageRoute(builder: (context) =>
            new ToTrinhXuLyDetail(id: id, chuDe: title, callBackRefresh: () =>
                setState((){  searchNotification();})
            )));
          }
      if(type=='THUNHAN')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new ThuDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
      if(type=='VBDI')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new VanBanDiDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
      if(type=='VBDEN')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new VanBanDenDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
      if(type=='THONGBAO')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new ThongBaoDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
      if(type=='MEETING')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new MeetingDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
      if(type=='LICHCONGTAC')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new LichCongTacDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
      if(type=='LICHDONVI')
      {
        Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        new LichDonViDetail(id: id, chuDe: title, callBackRefresh: () =>
            setState((){  searchNotification();})
        )));
      }
  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, NotificationItem>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<NotificationItem>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>  ListTile(
              minLeadingWidth: 0,
              contentPadding:UIUtils.paddingLite,
              subtitle: Container(
                  padding: UIUtils.paddingLiteSubTitle,
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row( children:[
                              UIUtils.setTextLong(item.body)
                            ]
                            )
                          ]
                      )
                    ],
                  ),
                  decoration: UIUtils.setBorderBox()

              ),
              title:Container(
                        child: UIUtils.setTextBoldTitle(item.title)
              ),

              onTap: (){
                  ServiceNotification().updateStatus(item.id).then((value) {
                  })
                      .catchError((e){
                    UIUtils.showToastError(e.toString(), context);
                  });
                  showDetail(item.notificationType, item.codeId, item.title);
              }

            )
        )
    );
    return new WillPopScope(child:  Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title:  UIUtils.setTextAppTitle(this.title)

        ),
        body: page,
        bottomNavigationBar: BottomBarAction(pageCurrent: ParamUtils.bottomPageTinMoiNhan)

      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
         this.searchNotification();
          return new Future.value(true);
        });


  }


}
