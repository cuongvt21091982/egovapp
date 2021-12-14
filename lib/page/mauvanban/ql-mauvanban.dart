import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/mauvanban/mauvanban.dart';
import 'package:egovapp/model/vanbanphapquy/vanbanphapquy.dart';
import 'package:egovapp/page/mauvanban/xuly/detail.dart';
import 'package:egovapp/page/vanbanphapquy/xuly/detail.dart';
import 'package:egovapp/page/vanbanphapquy/xuly/vanbanphapquy-edit.dart';
import 'package:egovapp/service/mauvanban/service-mauvanban.dart';
import 'package:egovapp/service/vanbanphapquy/service-vanbanphapquy.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class QLMauVanBan extends StatefulWidget
{
  const QLMauVanBan({Key? key}) : super(key: key);
  @override
  _QLMauVanBanState createState() => _QLMauVanBanState();
}
class _QLMauVanBanState extends State<QLMauVanBan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int maLoaiVanBan=ParamUtils.valueDefault;

  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,MauVanBan> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceMauVanBan().getPaging(txtKeyword.text,ParamUtils.stringEmpty,maLoaiVanBan,page, size).then((value)
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
  void _createMauVanBan() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditVanBanPhapQuy(id: 0, title: Language.getText('create_thongbao'), callBackRefresh: () =>
        setState((){  search();}, )
      ,)), );
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  search()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, MauVanBan>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MauVanBan>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>  ListTile(
                minLeadingWidth: 0,
                contentPadding:UIUtils.paddingLite,
                subtitle: Container(
                    padding: UIUtils.paddingLiteSubTitle,
                    child: UIUtils.setTextStartByItem(item.nhomMauVanBan.ten),
                    decoration: UIUtils.setBorderBox()

                ),
                title: UIUtils.setTextHeaderItem(item.tenVanBan),
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                  new MauVanBanDetail(id: item.id, chuDe: item.tenVanBan, callBackRefresh: () =>
                      setState((){  search();})
                  )));
                  //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
                }

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
                hintText: Language.getText("danhsach-mauvanban"),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonSearch,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      this.search();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: page,
        floatingActionButton: FloatingActionButton(
          onPressed: _createMauVanBan,
          tooltip: Language.getText('create_mauvanban'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: BottomBarAction()
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.search();
          return new Future.value(true);
        });


  }


}
