import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/email/documentdraft.dart';
import 'package:egovapp/model/email/thu.dart';
import 'package:egovapp/page/email/xuly/detail.dart';
import 'package:egovapp/page/email/xuly/thu-edit.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ThuDaNhan extends StatefulWidget
{
  const ThuDaNhan({Key? key}) : super(key: key);
  @override
  _ThuDaNhanState createState() => _ThuDaNhanState();
}
class _ThuDaNhanState extends State<ThuDaNhan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int deleteId = 0;
  int read=ParamUtils.valueDefault;
  int del=ParamUtils.statusOFF;
  String status=ParamUtils.statusChuaXuLy.toString();
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,Thu> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceThu().getPaging(keyword,UserAuthSession.staffId,read,del,status,page, size).then((value)
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
  void _createEmail() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditThu(id: 0, title: Language.getText('create_email'), callBackRefresh: () =>
        setState((){  searchEmail();}, )
      ,)), );
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  searchEmail()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, Thu>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Thu>(
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
                                UIUtils.getIconGhim(item.ghim),
                                UIUtils.setNamePerson(item.nguoiGui.fullName)
                              ]
                              ),
                              Row( children:[
                                UIUtils.setNameDate(item.ngayTao)
                              ]
                              )
                            ]
                        )
                      ],
                    ),
                    decoration: UIUtils.setBorderBox()

                ),
                title:Container(
                      child:UIUtils.setTextHeaderEmailItem(item.vanDe, item.checkread)
                ),
                leading: UIUtils.setCircleAvatarStatusItem(item.nguoiGui.ten, item.checkread == ParamUtils.statusOFF? ParamUtils.statusChuaXuLy: ParamUtils.statusDangXuLy)
                ,
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                  new ThuDetail(id: item.id, chuDe: item.vanDe,  callBackRefresh: () =>
                      setState((){  searchEmail();})
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
                hintText: Language.getText("thunhan"),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonSearch,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      this.searchEmail();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: page,
        floatingActionButton: FloatingActionButton(
          onPressed: _createEmail,
          tooltip: Language.getText('create_email'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: BottomBarAction(pageCurrent: ParamUtils.bottomPageEmail)
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.searchEmail();
          return new Future.value(true);
        });


  }


}
