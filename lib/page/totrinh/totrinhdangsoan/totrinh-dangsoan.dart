import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import '../xuly/edittotrinh.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ToTrinhDangSoan extends StatefulWidget
{
  const ToTrinhDangSoan({Key? key}) : super(key: key);
  @override
  _ToTrinhDangSoanState createState() => _ToTrinhDangSoanState();
}
class _ToTrinhDangSoanState extends State<ToTrinhDangSoan>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  final txtKeyword = TextEditingController();
  List<ToTrinh> dataList= [];
  int deleteId =0;
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,ToTrinh> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceToTrinh().getPaging(keyword,ParamUtils.statusDraft.toString(),UserAuthSession.staffId, ParamUtils.valueDefault, ParamUtils.dateDefault,ParamUtils.dateDefault, page, size).then((value)
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
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceToTrinh().delete(deleteId).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      setState((){  searchToTrinh();} );


    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
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
    var page=PagedListView<int, ToTrinh>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ToTrinh>(
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
                    UIUtils.setTextHeaderItem(item.chuDe)
                  ]),

              leading: UIUtils.setCircleAvatarStatusItem(item.nguoiTrinh.ten, item.trangThai),
                trailing: PopupMenuButton(
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
                      new EditToTrinh(id: item.id,
                          title: Language.getText('capnhattotrinh'),
                          callBackRefresh: () =>
                              setState(() {
                                this.searchToTrinh();
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
                hintText: Language.getText("totrinhdangsoan"),
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
