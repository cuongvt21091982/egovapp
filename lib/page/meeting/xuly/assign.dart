import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/meeting/service-meeting.dart';
import 'package:flutter/material.dart';
class AssignMeeting extends StatefulWidget
{
  const AssignMeeting({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _AssignMeetingState createState() => _AssignMeetingState();}
class _AssignMeetingState extends State<AssignMeeting>
{
  List<Staff> staffsSelect = [];
  String users= '';
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
    }
  }
  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceMeeting().joinMeeting(this.widget.id, this.staffsSelect.map((e) => e.id).toList().join(',')).then((value) {
      UIUtils.showToastSuccess(Language.getText('message_add_nguoihop_success') , context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context, true);
    }).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  @override
  Widget build(BuildContext context) {
    var formEdit=Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoihop')) ,
              padding: UIUtils.paddingForm,
            ) ,
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: UIUtils.paddingLite,
                        child: TextButton.icon(onPressed: () async{
                          if(this.staffsSelect.length ==0 )
                            UIUtils.showToastError(Language.getText("select_empty_required"), context);
                          else
                          if (formKey.currentState!.validate()) {
                            UIAction(actionForm).showDialogConfirm(context,
                                Language.getText('assign_staff_hop_question'));
                          }
                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("assign_staff_hop")
                          ),

                        )
                    )
                    ,
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton.icon(onPressed: () async {
                          Navigator.pop(context, true);
                        },
                          style:UIUtils.setButtonCancelStyle(),
                          icon: UIUtils.setButtonIcon(Icons.cancel) ,
                          label: UIUtils.setButtonResetText(Language.getText("no")
                          ),

                        )
                    )
                  ],)
            )

          ],
        ),
      ),
    );
    return new WillPopScope(child:  Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title: Text(widget.title),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: formEdit
    ),
        onWillPop:  () {
          this.widget.callBackRefresh();
          return new Future.value(true);
        });

  }
}
