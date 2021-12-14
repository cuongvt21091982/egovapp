import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/page/datphong/xuly/dangkyphong-edit.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/vpp/service-dangkyhop.dart';
import 'package:flutter/material.dart';
class AppBarDangKyDatPhongXuLyAction extends StatefulWidget {
  const AppBarDangKyDatPhongXuLyAction({Key? key, required this.id,
    required this.title,
    required this.callBackRefresh}) : super(key: key);
  final VoidCallback callBackRefresh;
  final int id;
  final String title;
  @override
  _AppBarDangKyDatPhongXuLyActionState createState() => _AppBarDangKyDatPhongXuLyActionState();
}

class _AppBarDangKyDatPhongXuLyActionState extends State<AppBarDangKyDatPhongXuLyAction> {
  List<PopupMenuEntry<String>> menuList= [];
  @override
  void initState() {
    super.initState();
    ServiceDangKyHop().getById(this.widget.id).then((value){
      if(value.trangThai == ParamUtils.statusChuaXuLy || value.trangThai == ParamUtils.statusDangXuLy) {
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionUpdate,
          child: UIUtils.setMenuIconText(
              Language.getText('update'), Icons.edit),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionDelete,
          child: UIUtils.setMenuIconText(
              Language.getText('delete'), Icons.delete_rounded),
        ));
      }


    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceDangKyHop().delete(this.widget.id).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context,true);

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      Row(
          children: <Widget>[
            PopupMenuButton(
                itemBuilder: (context) {
                  return menuList;
                },
                onSelected: (String value) async{
                  if(value==ParamUtils.actionUpdate) {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditDangKyPhong(id: this.widget.id,
                        title: Language.getText('capnhatdangkyphonghop'), callBackRefresh: () =>
                            setState((){ })
                    )),);
                  }
                  if(value==ParamUtils.actionDelete) {
                    UIAction(_delete).showDialogConfirm(context, Language.getText('message_delete_question') );
                  }
                })
          ]
      );


  }


}
