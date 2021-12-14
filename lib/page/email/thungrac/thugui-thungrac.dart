import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/email/thutemp.dart';
import 'package:egovapp/page/email/xuly/bottom-bar-thungrac.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/email/service-thutemp.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ThungRacThuDaGui extends StatefulWidget
{
  const ThungRacThuDaGui({Key? key}) : super(key: key);
  @override
  _ThungRacThuDaGuiState createState() => _ThungRacThuDaGuiState();
}
class _ThungRacThuDaGuiState extends State<ThungRacThuDaGui>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int deleteId = 0;
  int read=ParamUtils.valueDefault;
  int del=ParamUtils.statusON;
  String status=ParamUtils.statusChuaXuLy.toString();
  List<ThuTemp> thuTempSelect=[];
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  List<PopupMenuEntry<String>> menuList= [];
  final PagingController<int,ThuTemp> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceThuTemp().getPaging(keyword,UserAuthSession.staffId,read,del,page, size).then((value)
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
  dynamic _restore() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThuTemp().deleteAllByIds( this.thuTempSelect.map((e) => e.id).toList().join(','),ParamUtils.statusON,0).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_restore_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.searchEmail();

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _restoreAll() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThuTemp().deleteAllByNguoiGui(UserAuthSession.staffId,ParamUtils.statusON,2).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_restore_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.searchEmail();
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThuTemp().deleteAllByIds( this.thuTempSelect.map((e) => e.id).toList().join(','),ParamUtils.statusON,2).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_vinhvien_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.searchEmail();

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _deleteAll() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThuTemp().deleteAllByNguoiGui(UserAuthSession.staffId,ParamUtils.statusON,2).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_vinhvien_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.searchEmail();
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _restoreAlert() async
  {
    UIAction(_restore).showDialogConfirm(context, Language.getText('message_restore_question') );
  }
  dynamic _restoreAllAlert() async
  {
    UIAction(_restoreAll).showDialogConfirm(context, Language.getText('message_restore_tatca_question') );
  }
  dynamic _deleteAlert() async
  {
    UIAction(_delete).showDialogConfirm(context, Language.getText('message_delete_vinhvien_question') );
  }
  dynamic _deleteAllAlert() async
  {
    UIAction(_deleteAll).showDialogConfirm(context, Language.getText('message_delete_tatca_vinhvien_question') );
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
    var page=PagedListView<int, ThuTemp>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ThuTemp>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>  CheckboxListTile(
                contentPadding:UIUtils.paddingLite,
                subtitle: Container(
                    padding: UIUtils.paddingLiteSubTitle,
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row( children:[
                                UIUtils.setNamePerson(item.nguoiTaoItem.fullName)
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
                  child:  UIUtils.setTextHeaderEmailItem(item.vanDe, item.checkread),
                ),
                value: true,
                onChanged: (bool? value) {
                  setState(() {
                    if(value == true && this.thuTempSelect.indexWhere( (x) => x.id == item.id) ==-1)
                      this.thuTempSelect.add(item);
                    if(value == false && this.thuTempSelect.indexWhere( (x) => x.id == item.id) !=-1)
                      this.thuTempSelect.remove(item);
                  });
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
                hintText: Language.getText("thungracthudagui"),
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
         bottomNavigationBar:  BottomBarThungRacAction(
             deleteItem:  _deleteAlert,
             deleteAll:  _deleteAllAlert,
             restoreItem:  _restoreAlert,
             restoreAll: _restoreAllAlert
         )
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.searchEmail();
          return new Future.value(true);
        });


  }


}
