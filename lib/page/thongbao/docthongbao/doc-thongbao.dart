import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/thongbao/thongbao.dart';
import 'package:egovapp/page/thongbao/xuly/detail.dart';
import 'package:egovapp/page/thongbao/xuly/thongbao-edit.dart';
import 'package:egovapp/service/thongbao/service-thongbao.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class DocThongBao extends StatefulWidget
{
  const DocThongBao({Key? key}) : super(key: key);
  @override
  _DocThongBaoState createState() => _DocThongBaoState();
}
class _DocThongBaoState extends State<DocThongBao>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int xem= ParamUtils.valueDefault;
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,ThongBao> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceThongBao().getPaging(keyword,UserAuthSession.staffId, ParamUtils.valueDefault,page, size).then((value)
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
  void _createMeeting() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditThongBao(id: 0, title: Language.getText('create_thongbao'), callBackRefresh: () =>
        setState((){  searchMeeting();}, )
      ,)), );
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  searchMeeting()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, ThongBao>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ThongBao>(
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
                              UIUtils.setTextStartByItem(item.ngayHieuLuc)
                            ]
                            ), Row( children:[
                              UIUtils.setTextEndByItem(item.ngayHetHieuLuc)
                            ]
                            )
                          ]
                      )
                    ],
                  ),
                  decoration: UIUtils.setBorderBox()

              ),
              title:Column(
                children: [
                  Row(
                      children: <Widget>[
                        UIUtils.setTextHeaderItem(item.chuDe),
                      ]),
                  Row(
                      children: <Widget>[
                        UIUtils.setTextHeaderItem(Language.getText("nguoichutri")+": "+item.nguoiNhapItem.fullName)
                      ])
                ],
              )
              ,
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                new ThongBaoDetail(id: item.id, chuDe: item.chuDe, callBackRefresh: () =>
                    setState((){  searchMeeting();})
                )));
                //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
              },
              leading: UIUtils.setCircleAvatarStatusItem(item.nguoiNhapItem.ten != '' ? item.nguoiNhapItem.ten: ParamUtils.nameDefault, ParamUtils.statusSuccess),

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
                hintText: Language.getText("danhsach_thongbao"),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonSearch,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      this.searchMeeting();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: page,
        floatingActionButton: FloatingActionButton(
          onPressed: _createMeeting,
          tooltip: Language.getText('create_thongbao'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: BottomBarAction(pageCurrent: ParamUtils.bottomPageThongBao)
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.searchMeeting();
          return new Future.value(true);
        });


  }


}
