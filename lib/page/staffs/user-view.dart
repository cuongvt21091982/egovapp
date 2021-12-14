import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/danhmuc/donvi.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/staffs/workgroup.dart';
import 'package:egovapp/service/danhmuc/service-donvi.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:egovapp/service/staffs/service-workgroup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
class UserViewDialog extends StatefulWidget
{
  const UserViewDialog({Key? key, required this.refreshSelect,
                                  required this.staffsSelect}) : super(key: key);
  final Function() refreshSelect;
  final List<Staff> staffsSelect;
  @override
  _UserViewDialog createState() => _UserViewDialog();
}

class _UserViewDialog extends  State<UserViewDialog> {
  int id = 0;
  String title = Language.getText('danhsachnhansu');
  String keyword ='';
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  ServiceStaffs serviceStaffs = new ServiceStaffs();
  List<DonVi> donViList=[];
  PagingController<int,Staff> _pagingController = PagingController(firstPageKey: 0);
  @override
  void initState() {
    super.initState();
  }
  Future<List<DonVi>> getData(String? filter)
  {
    return ServiceDonVi().getAllDonVi().catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  @override
  Future<void> _fetchPage(int pageKey) async {
      String dv = this.donViList.length > 0 ? this.donViList.map((e) => e.id)
          .toList()
          .join(',') : '-1';
      serviceStaffs.getPaging('', dv, page, size).then((value) {
        debugPrint('SO L:' + value.length.toString());
        try {
          final isLastPage = value.length < size;
          if (isLastPage) {
            _pagingController.appendLastPage(value);
          } else {
            page += 1;
            final nextPageKey = pageKey + value.length;
            _pagingController.appendPage(value, nextPageKey);
          }
        } catch (error) {
          _pagingController.error = error;
        }
      }).catchError((onError) {
        UIUtils.showToastError(onError.toString(), context);
      });

  }
  @override
  Widget build(BuildContext context) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    var contentPage=PagedListView<int, Staff>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Staff>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>
                Container(
                  child: CheckboxListTile(
                      title: Container(
                        padding: UIUtils.paddingForm,
                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              UIUtils.setTextUserName(item.fullName ),
                            ]),
                      ) ,
                      subtitle:  Container(
                        padding: UIUtils.paddingForm,
                        child: Row(
                            children: [
                              UIUtils.getIconLevel(),
                              UIUtils.setDescriptionLevel(item.chucVuItem.tenChucVu+ '-'+ item.donViItem.tenCQ)
                            ]
                        ),
                      ),
                      value: (this.widget.staffsSelect.indexWhere( (x) => x .id == item.id) !=-1),
                      onChanged: (bool? value) {
                          setState(() {
                            if(value == true && this.widget.staffsSelect.indexWhere( (x) => x.id == item.id) ==-1)
                              this.widget.staffsSelect.add(item);
                            if(value == false && this.widget.staffsSelect.indexWhere( (x) => x.id == item.id) !=-1)
                              this.widget.staffsSelect.remove(item);

                          });
                      }
                  ),
                  decoration: UIUtils.setBorderBox(),
                )

        )
    );
    var bodyContent = Column(
      children: [
        Container(
          child:
          DropdownSearch<DonVi>.multiSelection(
            mode: Mode.DIALOG,
            showSearchBox: true,
            showClearButton: true,
            label: Language.getText('select_donvi'),
            hint: Language.getText('select_hint_donvi'),
            onFind: (String? filter) => getData(filter),
            itemAsString: (DonVi? u) => u!.tenCQ,
            onChange: (data) {
              donViList=[];
              donViList.addAll(data);
              this.page = Enviroments.currentPage;
              _pagingController.refresh();
            }

          )

            ,
          padding: EdgeInsets.fromLTRB(5.0, 5.0,5.0, 5.0),
        ),
           Expanded(
             child: contentPage
           )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIUtils.colorDialog,
        title: Text(this.title),
        actions: [
        IconButton(onPressed: (){
          this.widget.refreshSelect();
          Navigator.pop(context, true);
        },
          icon:Icon( Icons.check_circle, color: Colors.white, size: 30)
        )
        ],
      ),
      body: bodyContent
    );
  }
}

class UserGroupViewDialog extends StatefulWidget
{
  const UserGroupViewDialog({Key? key, required this.refreshSelect,
    required this.staffsSelect}) : super(key: key);
  final Function() refreshSelect;
  final List<Staff> staffsSelect;
  @override
  _UserGroupViewDialog createState() => _UserGroupViewDialog();
}

class _UserGroupViewDialog extends  State<UserGroupViewDialog> {
  int id = 0;
  String title = Language.getText('danhsachnhansu');
  String keyword ='';
  int page = Enviroments.currentPage;
  int size= Enviroments.pageSize;
  ServiceStaffs serviceStaffs = new ServiceStaffs();
  List<WorkGroup> workGroupList=[];
  PagingController<int,Staff> _pagingController = PagingController(firstPageKey: 0);
  @override
  void initState() {
    super.initState();
  }

  Future<List<WorkGroup>> getDataWorkGroup(String? filter)
  {
    return ServiceWorkGroup().getAllWorkGroup(UserAuthSession.staffId).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  @override
  Future<void> _fetchPage(int pageKey) async {

    String dv= this.workGroupList.length>0?  this.workGroupList.map((e) => e.id).toList().join(','): '-1';
    serviceStaffs.getAllByWorkGroupId(dv).then((value)
    {
      debugPrint('SO WG:'+value.length.toString()+"-"+pageKey.toString());
      try {
        final isLastPage = value.length < 5000;
        if (isLastPage) {
          _pagingController.appendLastPage(value);
        } else {
          page +=1;
          final nextPageKey = pageKey + value.length;
          _pagingController.appendPage(value, nextPageKey);
        } } catch (error) {
        _pagingController.error = error;
      }
    }).catchError((onError){
      UIUtils.showToastError(onError.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    var contentPage=PagedListView<int, Staff>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Staff>(
            noItemsFoundIndicatorBuilder: UIUtils.noFoundItem,
            itemBuilder: (context, item, index) =>
                Container(
                  child: CheckboxListTile(
                      title: Container(
                        padding: UIUtils.paddingForm,
                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              UIUtils.setTextUserName(item.fullName ),
                            ]),
                      ) ,
                      subtitle:  Container(
                        padding: UIUtils.paddingForm,
                        child: Row(
                            children: [
                              UIUtils.getIconLevel(),
                              UIUtils.setDescriptionLevel(item.chucVuItem.tenChucVu+ '-'+ item.donViItem.tenCQ)
                            ]
                        ),
                      ),
                      value: (this.widget.staffsSelect.indexWhere( (x) => x .id == item.id) !=-1),
                      onChanged: (bool? value) {
                        setState(() {
                          if(value == true && this.widget.staffsSelect.indexWhere( (x) => x.id == item.id) ==-1)
                            this.widget.staffsSelect.add(item);
                          if(value == false && this.widget.staffsSelect.indexWhere( (x) => x.id == item.id) !=-1)
                            this.widget.staffsSelect.remove(item);

                        });
                      }
                  ),
                  decoration: UIUtils.setBorderBox(),
                )

        )
    );
    var bodyContent = Column(
      children: [
        Container(
          child:
          DropdownSearch<WorkGroup>.multiSelection(
              mode: Mode.DIALOG,
              showSearchBox: true,
              showClearButton: true,
              label: Language.getText('workgroup'),
              hint: Language.getText('select_workgroup'),
              onFind: (String? filter) => getDataWorkGroup(filter),
              itemAsString: (WorkGroup? u) => u!.tenNhom,
              onChange: (data) {
                workGroupList=[];
                workGroupList.addAll(data);
                this.page = Enviroments.currentPage;
                _pagingController.refresh();
              }

          )

          ,
          padding: EdgeInsets.fromLTRB(5.0, 5.0,5.0, 5.0),
        ),
        Expanded(
            child: contentPage
        )
      ],
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorDialog,
          title: Text(this.title),
          actions: [
            IconButton(onPressed: (){
              this.widget.refreshSelect();
              Navigator.pop(context, true);
            },
                icon:Icon( Icons.check_circle, color: Colors.white, size: 30)
            )
          ],
        ),
        body: bodyContent
    );
  }
}
