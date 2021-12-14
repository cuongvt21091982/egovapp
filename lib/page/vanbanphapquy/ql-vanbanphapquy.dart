import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/vanbanphapquy/vanbanphapquy.dart';
import 'package:egovapp/page/vanbanphapquy/xuly/detail.dart';
import 'package:egovapp/page/vanbanphapquy/xuly/vanbanphapquy-edit.dart';
import 'package:egovapp/service/vanbanphapquy/service-vanbanphapquy.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class QLVanBanPhapQuy extends StatefulWidget
{
  const QLVanBanPhapQuy({Key? key}) : super(key: key);
  @override
  _QLVanBanPhapQuyState createState() => _QLVanBanPhapQuyState();
}
class _QLVanBanPhapQuyState extends State<QLVanBanPhapQuy>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  String soHieuGoc= '';
  String noiGui= '';
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,VanBanPhapQuy> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceVanBanPhapQuy().getPaging(soHieuGoc,keyword,noiGui,page, size).then((value)
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
  void _createVanBanPhapQuy() {
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
    var page=PagedListView<int, VanBanPhapQuy>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<VanBanPhapQuy>(
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
                                UIUtils.setTextStartByItem(Language.getText("luotnguoidoc")+": "+item.soLuotDoc.toString())
                              ]
                              ),
                              Row( children:[
                                UIUtils.setTextStartByItem(item.ngayKy)
                              ]
                              )
                            ]
                        )
                      ],
                    ),
                    decoration: UIUtils.setBorderBox()

                ),
                title: UIUtils.setTextLong(item.soHieuGoc+"-"+item.trichYeu)
                ,
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                  new VanBanPhapQuyDetail(id: item.id, chuDe: item.soHieuGoc+" - "+ item.trichYeu, callBackRefresh: () =>
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
                hintText: Language.getText("danhsach-vanbanphapquy"),
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
          onPressed: _createVanBanPhapQuy,
          tooltip: Language.getText('create_vanbanphapquy'),
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
