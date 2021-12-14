import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/email/documentdraft.dart';
import 'package:egovapp/page/email/xuly/thu-edit.dart';
import 'package:egovapp/page/thongbao/xuly/detail.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/email/service-documentdraft.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ThuDangSoan extends StatefulWidget
{
  const ThuDangSoan({Key? key}) : super(key: key);
  @override
  _ThuDangSoanState createState() => _ThuDangSoanState();
}
class _ThuDangSoanState extends State<ThuDangSoan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int deleteId = 0;
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,DocumentDraft> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceDocumentDraft().getPaging(keyword,ParamUtils.docTypeEmail,UserAuthSession.staffId,page, size).then((value)
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
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceDocumentDraft().delete(deleteId).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      setState((){  searchEmail();} );


    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  searchEmail()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, DocumentDraft>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<DocumentDraft>(
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
                                UIUtils.setNameDate(item.thoiGianNhap)
                              ]
                              )
                            ]
                        )
                      ],
                    )

                ),
                title:  Container(
                          child:  UIUtils.setTextHeaderEmailItem(item.chuDe, ParamUtils.statusChuaXuLy)
                )
                ,
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                  new ThongBaoDetail(id: item.id, chuDe: item.chuDe, callBackRefresh: () =>
                      setState((){  searchEmail();})
                  )));
                  //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
                },
                trailing:  PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: ParamUtils.actionUpdate,
                        child: UIUtils.setMenuIconText(Language.getText('update'), Icons.edit),
                      ),
                      PopupMenuItem(
                        value: ParamUtils.actionDelete,
                        child: UIUtils.setMenuIconText(Language.getText('delete'), Icons.delete_rounded),
                      )
                    ];
                  },
                  onSelected: (String value) async{
                    if(value==ParamUtils.actionDelete) {
                      this.deleteId = item.id;
                      UIAction(_delete).showDialogConfirm(
                          context, Language.getText('message_delete_question'));
                    }
                    if(value==ParamUtils.actionUpdate) {
                      Navigator.push(
                        context, new MaterialPageRoute(builder: (context) =>
                      new EditThu(id: item.id,
                          title: Language.getText('capnhatemail'),
                          callBackRefresh: () =>
                              setState(() {
                                this.searchEmail();
                              })
                      )),);
                    }
                  },
                )

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
                hintText: Language.getText("thudangsoan"),
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
