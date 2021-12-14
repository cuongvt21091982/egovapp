import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import 'package:egovapp/model/totrinh/totrinhxuly.dart';
import '../xuly/detail.dart';
import '../xuly/edittotrinh.dart';
import 'package:egovapp/page/totrinh/totrinhnhan/xuly.dart';
import 'package:egovapp/service/totrinh/service-totrinhxuly.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ToTrinhNhan extends StatefulWidget
{
  const ToTrinhNhan({Key? key}) : super(key: key);
  @override
  TToTrinhNhanState createState() => TToTrinhNhanState();
}
class TToTrinhNhanState extends State<ToTrinhNhan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  final txtKeyword = TextEditingController();
  List<ToTrinh> dataList= [];
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,ToTrinhXuLy> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceToTrinhXuLy().getPaging(keyword,ParamUtils.statusArrayAll,UserAuthSession.staffId, ParamUtils.valueDefault, ParamUtils.dateDefault,ParamUtils.dateDefault, page, size).then((value)
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
  void _createToTrinh() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditToTrinh(id: 0, title: Language.getText('totrinh_add'), callBackRefresh: () =>
        setState((){  searchToTrinh();}, )
      ,)), );
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  searchToTrinh()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, ToTrinhXuLy>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ToTrinhXuLy>(
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
                    if(item.toTrinhFiles.length >0)
                      UIUtils.getIconAttachFile()
                  ]),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                new ToTrinhXuLyDetail(id: item.maYeuCau, chuDe: item.chuDe, callBackRefresh: () =>
                    setState((){  searchToTrinh();})
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
                hintText: Language.getText("totrinhnhan"),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonSearch,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      this.searchToTrinh();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: page,
        floatingActionButton: FloatingActionButton(
          onPressed: _createToTrinh,
          tooltip: Language.getText('create_totrinh'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: BottomBarAction()
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.searchToTrinh();
          return new Future.value(true);
        });


  }


}
