import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/vpp/dangkyhop.dart';
import 'package:egovapp/page/datphong/xuly/dangkyphong-edit.dart';
import 'package:egovapp/page/datphong/xuly/detailapproved.dart';
import 'package:egovapp/service/vpp/service-dangkyhop.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class DatPhongDuyetYeuCau extends StatefulWidget
{
  const DatPhongDuyetYeuCau({Key? key}) : super(key: key);
  @override
  _DatPhongDuyetYeuCauState createState() => _DatPhongDuyetYeuCauState();
}
class _DatPhongDuyetYeuCauState extends State<DatPhongDuyetYeuCau>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int thietBiId=ParamUtils.valueDefault;
  int status=ParamUtils.valueDefault;
  final txtKeyword = TextEditingController();
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,DangKyHop> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceDangKyHop().getPagingPheDuyet(keyword,thietBiId,status, UserAuthSession.staffId,page, size).then((value)
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
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditDangKyPhong(id: 0, title: Language.getText('create_thongbao'), callBackRefresh: () =>
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
    var page=PagedListView<int, DangKyHop>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<DangKyHop>(
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
                                UIUtils.setTextStartByItem(Language.getText("phong")+": "+item.phong.tenPhong)
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
                  new DangKyDatPhongDetailApproved(id: item.dangKyId, chuDe: item.noiDung, callBackRefresh: () =>
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
                hintText: Language.getText("duyetyeucau"),
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
          tooltip: Language.getText('dangkyphonghop'),
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
