import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/hoso/hoso.dart';
import 'package:egovapp/page/hoso/canhan/xuly/detail.dart';
import 'package:egovapp/page/hoso/canhan/xuly/hosocanhan-edit.dart';
import 'package:egovapp/service/hoso/service-hoso.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class QLHoSoCaNhan extends StatefulWidget
{
  const QLHoSoCaNhan({Key? key}) : super(key: key);
  @override
  _QLHoSoCaNhanState createState() => _QLHoSoCaNhanState();
}
class _QLHoSoCaNhanState extends State<QLHoSoCaNhan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int xem= ParamUtils.valueDefault;
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,HoSo> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceHoSo().getPaging(keyword,ParamUtils.hoSoDonVi.toString(),UserAuthSession.staffId,  page, size).then((value)
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
  void _create() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditHoSoCaNhan(id: 0, title: Language.getText('create_meeting'), callBackRefresh: () =>
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
    var page=PagedListView<int, HoSo>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<HoSo>(
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
                              UIUtils.setTextBoldTitle(item.ngayTao)
                            ]
                            )
                          ]
                      )
                    ],
                  ),
                  decoration: UIUtils.setBorderBox()

              ),
              title: UIUtils.setTextLong(item.tenHoSo)
              ,
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                new HoSoCaNhanDetail(
                    id: item.id, chuDe: item.tenHoSo, callBackRefresh: () =>
                    setState((){  search();})
                )));
                //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
              },
              leading: UIUtils.setCircleAvatarStatusItem(item.nguoiTao.ten != '' ? item.nguoiTao.ten: ParamUtils.nameDefault, ParamUtils.statusHoanThanh),

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
                hintText: Language.getText("danhsach_hosocanhan"),
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
          onPressed: _create,
          tooltip: Language.getText('create_hoso'),
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
