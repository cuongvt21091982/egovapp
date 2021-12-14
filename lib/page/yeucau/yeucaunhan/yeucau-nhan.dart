import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/yeucau/yeucau.dart';
import 'package:egovapp/model/yeucau/yeucauxuly.dart';
import 'package:egovapp/page/yeucau/xuly/detail.dart';
import 'package:egovapp/page/yeucau/xuly/yeucau-edit.dart';
import 'package:egovapp/service/yeucau/service-yeucauxuly.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class YeuCauNhan extends StatefulWidget
{
  const YeuCauNhan({Key? key}) : super(key: key);
  @override
  _YeuCauNhanState createState() => _YeuCauNhanState();
}
class _YeuCauNhanState extends State<YeuCauNhan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  final txtKeyword = TextEditingController();
  List<YeuCau> dataList= [];
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,YeuCauXuLy> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceYeuCauXuLy().getPaging(keyword,ParamUtils.statusArrayAll,UserAuthSession.staffId, ParamUtils.valueDefault, ParamUtils.dateDefault,ParamUtils.dateDefault, page, size).then((value)
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
  void _createYeuCau() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditYeuCau(id: 0, title: Language.getText('yeucau_add'), callBackRefresh: () =>
        setState((){  searchYeuCau();}, )
      ,)), );
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  searchYeuCau()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, YeuCauXuLy>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<YeuCauXuLy>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>  ListTile(
              minLeadingWidth: 0,
              contentPadding:UIUtils.paddingLite,
              subtitle: Container(
                  padding: UIUtils.paddingLiteSubTitle,
                  child:
                  Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row( children:[
                              UIUtils.getTextStatus(item.trangThai)
                            ]
                            ), Row( children:[
                              UIUtils.setTextDateHeaderItem(item.thoiGianGui)
                            ]
                            )
                          ]
                      )
                    ],
                  ),
                  decoration: UIUtils.setBorderBox()

              ),
              title: Row(
                  children: <Widget>[
                    UIUtils.setTextHeaderItem(item.chuDe),
                    Spacer(),
                    if(item.yeuCauFiles.length >0)
                      UIUtils.getIconAttachFile()
                  ]),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                new YeuCauDetail(id: item.id, chuDe: item.chuDe, callBackRefresh: () =>
                    setState((){  searchYeuCau();})
                )));
                //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
              },
              leading: UIUtils.setCircleAvatarStatusItem(item.nguoiChuTri.ten, item.trangThai),

            )
        )
    );
    return new WillPopScope(child:  Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title:  TextField(
            cursorColor: Colors.black,
            controller: txtKeyword,
            decoration: InputDecoration(
                contentPadding: UIUtils.paddingSearhAppBar,
                hintText: Language.getText("giaoviecnhan"),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonSearch,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      this.searchYeuCau();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: page,
        floatingActionButton: FloatingActionButton(
          onPressed: _createYeuCau,
          tooltip: Language.getText('create_yeucau'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: BottomBarAction()
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.searchYeuCau();
          return new Future.value(true);
        });


  }


}
