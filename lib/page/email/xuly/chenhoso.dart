import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/hoso/hoso.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:egovapp/service/hoso/service-hoso.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class ThuChenHoSo extends StatefulWidget
{
  const ThuChenHoSo({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  _ThuChenHoSoState createState() => _ThuChenHoSoState();
}
class _ThuChenHoSoState extends State<ThuChenHoSo>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int xem= ParamUtils.valueDefault;
  int hoSoId=0;

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
  dynamic _insertHoSo() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThu().chenHoSo(this.widget.id, this.hoSoId).then((value){
      UIUtils.showToastSuccess(value == ParamUtils.statusSuccess ? Language.getText('message_chenhoso_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      Navigator.pop(context,true);
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
                this.hoSoId = item.id;
                UIAction(_insertHoSo).showDialogConfirm(context, Language.getText('message_chenhoso_question') );
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
                hintText: Language.getText("danhsachhoso"),
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
        body: page, bottomNavigationBar: BottomBarAction()
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.search();
          return new Future.value(true);
        });


  }


}
