import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/totrinh/totrinh.dart';
import 'package:egovapp/model/vanbanden/vanbanden.dart';
import 'package:egovapp/model/vanbandi/vanbandi.dart';
import 'package:egovapp/page/vanbanden/xuly/assign.dart';
import 'package:egovapp/page/vanbanden/xuly/vanbanden-edit.dart';
import 'package:egovapp/page/vanbandi/xuly/detail.dart';
import 'package:egovapp/page/vanbandi/xuly/vanbandi-edit.dart';
import 'package:egovapp/service/vanbanden/service-vanbanden.dart';
import 'package:egovapp/service/vanbandi/service-vanbandi.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class VBDiDaVaoSo extends StatefulWidget
{
  const VBDiDaVaoSo({Key? key}) : super(key: key);
  @override
  _VBDiDaVaoSoState createState() => _VBDiDaVaoSoState();
}
class _VBDiDaVaoSoState extends State<VBDiDaVaoSo>
{
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  int maLoaiVB=ParamUtils.valueDefault;
  int maLinhVuc=ParamUtils.valueDefault;
  int phoCap = ParamUtils.valueDefault;
  int nguoiNhapId= UserAuthSession.staffId;
  int nguoiChuTri =ParamUtils.valueDefault;
  int maNoiGui =ParamUtils.valueDefault;
  int maNhomVBDi=ParamUtils.valueDefault;
  final txtKeyword = TextEditingController();
  List<ToTrinh> dataList= [];
  String keyword = ParamUtils.stringEmpty;
  final PagingController<int,VanBanDi> _pagingController = PagingController(firstPageKey: 0);
  Future<void> _fetchPage(int pageKey) async {
    ServiceVanBanDi().getPaging(maNhomVBDi, keyword,maLoaiVB,maLinhVuc,ParamUtils.valueDefault.toString(),
        phoCap, nguoiNhapId,nguoiChuTri,ParamUtils.dateDefault,ParamUtils.dateDefault, page, size).then((value)
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
  void _createVanBanDi() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditVanBanDi(id: 0, title: Language.getText('create_vanbandi'), callBackRefresh: () =>
        setState((){  searchVanBanDi();}, )
      ,)), );
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  searchVanBanDi()
  {
    this.keyword = txtKeyword.text;
    this.page = Enviroments.currentPage;
    _pagingController.refresh();

  }
  @override
  Widget build(BuildContext context) {
    var page=PagedListView<int, VanBanDi>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<VanBanDi>(
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
                              UIUtils.getTextStatus(item.maTrangThaiXL)
                            ]
                            ), Row( children:[
                              UIUtils.setTextFooterByStatusItem(item.ngayVaoSo, item.maTrangThaiXL)
                            ]
                            )
                          ]
                      )
                    ],
                  ),
                  decoration: UIUtils.setBorderBox()

              ),
              title:Column(
                children: [
                  Row(
                      children: <Widget>[
                        UIUtils.setTextHeaderByStatusItem(item.soVaoSo+" - "+ item.trichYeu , item.maTrangThaiXL),
                      ]),
                  Row(
                      children: <Widget>[
                        UIUtils.setTextHeaderItem(Language.getText("nguoiky")+": "+ item.nguoiKy.fullName)
                      ])
                ],
              )
              ,
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                new VanBanDiDetail(id: item.id, chuDe: item.soVaoSo+" - "+item.trichYeu, callBackRefresh: () =>
                    setState((){  searchVanBanDi();})
                )));
                //Navigator.of(context).pushNamed("/totrinhguidetail", arguments: { 'id': item.id, 'title': item.chuDe});
              },
              leading: UIUtils.setCircleAvatarStatusItem(item.nguoiChuTri.ten != '' ? item.nguoiChuTri.ten: ParamUtils.nameDefault, item.maTrangThaiXL),

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
                hintText: Language.getText("vanbandidavaoso"),
                hintStyle: UIUtils.textStyleSearch,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    padding:  UIUtils.paddingButtonSearchAppBar,
                    icon: UIUtils.iconButtonSearch,
                    color: UIUtils.colorButtonSearch,
                    onPressed: () {
                      this.searchVanBanDi();
                    }
                )),
            style: UIUtils.textStyleSearch,
          ),
        ),
        body: page,
        floatingActionButton: FloatingActionButton(
          onPressed: _createVanBanDi,
          tooltip: Language.getText('create_vanbandi'),
          child: Icon(Icons.add),
        ), bottomNavigationBar: BottomBarAction()
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
        onWillPop: () {
          this.searchVanBanDi();
          return new Future.value(true);
        });


  }


}
