import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/vpp/dangky.dart';
import 'package:egovapp/page/vpp/xuly/dangky-edit.dart';
import 'package:egovapp/page/vpp/xuly/detail.dart';
import 'package:egovapp/service/vpp/service-dangky.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class VPPXemKetQua extends StatefulWidget
{
  const VPPXemKetQua({Key? key}) : super(key: key);
  @override
  _VPPXemKetQuaState createState() => _VPPXemKetQuaState();
}
class _VPPXemKetQuaState extends State<VPPXemKetQua>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int thietBiId=ParamUtils.valueDefault;
  int status=ParamUtils.valueDefault;
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,DangKy> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceDangKy().getPaging(keyword,thietBiId,status, UserAuthSession.staffId,page, size).then((value)
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
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditDangKy(id: 0, title: Language.getText('create_thongbao'), callBackRefresh: () =>
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
    var page=PagedListView<int, DangKy>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<DangKy>(
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
                                UIUtils.setTextStartByItem(Language.getText("thoigian")+": "+item.ngay+' '+ item.thoiGian)
                              ]
                              ),
                              Row( children:[
                                UIUtils.setTextStartByItem(Language.getText("thietbi")+": "+item.thietBi.tenThietBi)
                              ]
                              ),
                              Row( children:[
                                UIUtils.setTextStartByItem(Language.getText("nguoichutri")+": "+item.nguoiChuTri)
                              ]
                              ), Row( children:[
                                UIUtils.getTextStatusApproved(item.trangThai)
                              ]
                              )
                            ]
                        )
                      ],
                    ),
                    decoration: UIUtils.setBorderBox()

                ),
                title: UIUtils.setTextLong(item.noiDung)
                ,
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                  new DangKyDetail(id: item.dangKyId, chuDe: item.noiDung, callBackRefresh: () =>
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
                hintText: Language.getText("xemketquaduyet"),
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
          tooltip: Language.getText('dangkythietbi'),
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
