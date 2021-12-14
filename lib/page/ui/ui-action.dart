import 'dart:io';

import 'package:badges/badges.dart';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/model/calendar/event-calendar.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/staffs/user-view.dart';
import 'package:egovapp/service/calendar/service-eventcalendarsource.dart';
import 'package:egovapp/service/files/file-service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class UIAction {
  UIAction(this.callActionCommand);
  final Function() callActionCommand;
  void showDialogConfirm(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(Language.getText('alert')),
            content: Text(message),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  callActionCommand();
                },
                style: UIUtils.setButtonResetStyle(),
                icon: UIUtils.setButtonIcon(
                    Icons.check_circle_outline_outlined),
                label: Text(Language.getText('yes'), style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                icon: UIUtils.setButtonIcon(Icons.cancel),
                label: Text(Language.getText('no'), style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
            ],
          ),
    );
  }
}
class UIAlert {
  UIAlert();
  void showDialogConfirm(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(Language.getText('alert')),
            content: Text(message),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                icon: UIUtils.setButtonIcon(Icons.cancel),
                label: Text(Language.getText('close'), style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
            ],
          ),
    );
  }
}
//UI FORM ACTION
class UIFormAction
{
   TextFormField setTextFormField(TextEditingController textEdit,
      TextInputType inputType,
      String title, String description, bool validate, String messageRequired) {
    return TextFormField(
        autofocus: false,
        controller: textEdit,
        keyboardType: inputType,
        minLines: 1,
        maxLines: 10,
        decoration: UIUtils.setInputDecoration(title, description, validate),
        validator: (value) {
          if (validate && (value == null || value.isEmpty)) {
            return messageRequired;
          }
          return null;
        }
    );
   }
   TextFormField setTextFormNotLine(TextEditingController textEdit,
       TextInputType inputType,
       String title, String description, bool validate, String messageRequired) {
     return TextFormField(
         autofocus: false,
         controller: textEdit,
         keyboardType: inputType,
         decoration: UIUtils.setInputDecorationNoLine(title, description, validate),
         minLines: 1,
         maxLines: 10,
         validator: (value) {
           if (validate && (value == null || value.isEmpty)) {
             return messageRequired;
           }
           return null;
         }
     );
   }
   TextFormField setTextFormIcon(IconData icon,Color color,TextEditingController textEdit,
       TextInputType inputType,
       String title, String description, bool validate, String messageRequired) {
     return TextFormField(
         autofocus: false,
         controller: textEdit,
         keyboardType: inputType,
         decoration: UIUtils.setInputDecorationIcon(icon,color,title, description, validate),
         minLines: 1,
         maxLines: 10,
         validator: (value) {
           if (validate && (value == null || value.isEmpty)) {
             return messageRequired;
           }
           return null;
         }
     );
   }
   TextFormField setTextFormPasswordIcon(IconData icon,Color color,TextEditingController textEdit,
       TextInputType inputType,
       String title, String description, bool validate, String messageRequired) {
     return TextFormField(
         autofocus: false,
         obscureText: true,
         obscuringCharacter: "*",
         controller: textEdit,
         decoration: UIUtils.setInputDecorationIcon(icon,color,title, description, validate),

         validator: (value) {
           if (validate && (value == null || value.isEmpty)) {
             return messageRequired;
           }
           return null;
         }
     );
   }
   TextFormField setTextFormVisibleField(TextEditingController textEdit,
       TextInputType inputType,
       String title, String description) {
     return TextFormField(
         autofocus: false,
         enabled: false,
         controller: textEdit,
         keyboardType: inputType,
         minLines: 1,
         maxLines: 10,
         decoration: UIUtils.setInputDecoration(title, description, false),

     );
   }
}
//END UI FORM ACTION
//UI DATETIME ACTION
class UIDateTimeAction extends StatefulWidget
{
  const UIDateTimeAction({Key? key, required this.textEdit,
    required this.title,
    required this.description,
    required this.validate,
    required this.messageRequired}) : super(key: key);
  final TextEditingController textEdit;
  final String title;
  final String description;
  final bool validate;
  final String messageRequired;

  @override
  _UIDateTimeAction createState() => _UIDateTimeAction();
}
class _UIDateTimeAction extends State<UIDateTimeAction>
{
  @override
  Widget build(BuildContext context) {
      return TextFormField(
          autofocus: false,
          readOnly: true,
          controller: this.widget.textEdit,
          decoration: UIUtils.setInputDecoration(this.widget.title, this.widget.description, this.widget.validate),
          validator: (value) {
            if (this.widget.validate && (value == null || value.isEmpty)) {
              return this.widget.messageRequired;
            }
            return null;
          },
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(ParamUtils.yearFirst),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(ParamUtils.yearLast)
            );
            if(pickedDate != null ){
              String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
              setState(() {
                this.widget.textEdit.text = formattedDate;
              });
            }
          }
      );
  }
}
//END UI DATETIME ACTION
class AttachFileFormAction extends StatefulWidget
{
  const AttachFileFormAction({Key? key, required this.fileUploads, required this.deleteFile}): super(key: key);
  final  List<FileItem> fileUploads;
  final Function(FileItem id) deleteFile;
  @override
  _AttachFileFormAction createState() => _AttachFileFormAction();
}
class _AttachFileFormAction extends State<AttachFileFormAction>
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton.icon(onPressed: () async {
              FilePickerResult? files= await FilePicker.platform.pickFiles(type: FileType.custom,
                  allowedExtensions: ParamUtils.extensionFile,
                  allowMultiple: true
              );
              if(files!.files.isNotEmpty)
                setState(() =>
                  {
                    for(var file in files.files)
                      this.widget.fileUploads.add(new FileItem(
                          id: 0, key: file.name, name: file.name, path: file.path, action: false))
                  }
                );
            },
                style:UIUtils.setButtonAttachStyle(),
                icon: UIUtils.setButtonIcon(Icons.attach_file),
                label: UIUtils.setButtonText(Language.getText("filedinhkem")
                )
            ),

          ],
        )
      ,
          new Builder(
              builder: (BuildContext context1) =>  this.widget.fileUploads.length !=0 ?
              Container(
                  padding: UIUtils.paddingForm,
                  height: MediaQuery.of(context1).size.height* 0.09,
                  child:ListView.builder(
                      itemCount: this.widget.fileUploads.isNotEmpty ? this.widget.fileUploads.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final int fileNo = index + 1;
                        final String name = 'File $fileNo: ' + (this.widget.fileUploads.length !=0? this.widget.fileUploads[index].name:'');
                        //final path = this.fileUploads.length!=0 ? this.fileUploads[index].path : '';
                        return Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      title: Text(Language.getText('alert')),
                                      content: Text(Language.getText('question_delete_file')),
                                      actions: <Widget>[
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            this.widget.deleteFile(this.widget.fileUploads[index]);
                                          },
                                          style: UIUtils.setButtonResetStyle(),
                                          icon: UIUtils.setButtonIcon(
                                              Icons.check_circle_outline_outlined),
                                          label: Text(Language.getText('yes'), style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                        ),
                                        TextButton.icon(
                                          onPressed: () => Navigator.pop(context),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.red)),
                                          icon: UIUtils.setButtonIcon(Icons.cancel),
                                          label: Text(Language.getText('no'), style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                              );

                                },
                                icon:UIUtils.setButtonRemoveIcon(Icons.delete_forever_outlined),
                                label: UIUtils.setButtonFileText(this.widget.fileUploads[index].name)
                        )
                        );
                      }
                  )
              ): new Container()

          )
      ],
    );

  }
}

class ProfileFileFormAction extends StatefulWidget
{
  const ProfileFileFormAction({Key? key, required this.urlPath, required this.setKey}): super(key: key);
  final  String urlPath;
  final Function (String key) setKey;

  @override
  _ProfileFileFormAction createState() => _ProfileFileFormAction();
}
class _ProfileFileFormAction extends State<ProfileFileFormAction>
{
  String url='';
  ImageProvider? imageProvider;
  @override
  void initState() {
     super.initState();

     setState(() {
       if(this.widget.urlPath!='')
         {
          imageProvider= NetworkImage( ApiUtils().getUrlAvatar(this.widget.urlPath));
         }

     });


  }
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
            Container(
              child:
              CircleAvatar(
              radius: 100,
                  backgroundImage: imageProvider
                      )
            ),
            Container(
              child: TextButton.icon(onPressed: () async {
                FilePickerResult? files= await FilePicker.platform.pickFiles(type: FileType.custom,
                    allowedExtensions: ParamUtils.extensionFileImage,
                    allowMultiple: false
                );
                if(files!.files.isNotEmpty) {
                  FileService().upload(files.files[0].path!).then((value) {
                    this.widget.setKey(value.fileKey);
                  }).catchError((onError){

                  });
                  setState(() =>
                  {
                    this.imageProvider =FileImage(File(files.files[0].path!))
                  }
                  );
                }
              },
                  style:UIUtils.setButtonAttachStyle(),
                  icon: UIUtils.setButtonIcon(Icons.supervised_user_circle_rounded),
                  label: UIUtils.setButtonText(Language.getText("change_avatar")
                  )
              )   ,
            )


      ],
    );

  }
}
class UIShowDialog
{
  const UIShowDialog( {required this.actionCommand});
  final Function() actionCommand;
  void show(BuildContext context,String titleAction,
      Widget contentForm, double? width, double? height  )
  {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: new Container(
            decoration: UIUtils.setBoxDecorationDialogCustom(),
            width: width,
            height: height,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                contentForm,
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     TextButton.icon(
                       onPressed: () {
                         Navigator.pop(context);
                         actionCommand();
                       },
                       style: UIUtils.setButtonResetStyle(),
                       icon: UIUtils.setButtonIcon(
                           Icons.check_circle_outline_outlined),
                       label: Text(titleAction, style: TextStyle(
                           color: Colors.white,
                           fontSize: 12,
                           fontWeight: FontWeight.bold)),
                     ),
                     TextButton.icon(
                       onPressed: () => Navigator.pop(context),
                       style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Colors.red)),
                       icon: UIUtils.setButtonIcon(Icons.cancel),
                       label: Text(Language.getText('no'), style: TextStyle(
                           color: Colors.white,
                           fontSize: 12,
                           fontWeight: FontWeight.bold)),
                     )
                   ],
                ),)

              ],
            ),
          ),
        );
      },
    );

  }
}
class UICustomDialog {
  UICustomDialog(this.callActionCommand);
  final Function() callActionCommand;
  void show(BuildContext context, String title,  String titleAction,Widget form) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(title),
            content: form,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  callActionCommand();
                },
                style: UIUtils.setButtonResetStyle(),
                icon: UIUtils.setButtonIcon(
                    Icons.check_circle_outline_outlined),
                label: Text(titleAction, style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                icon: UIUtils.setButtonIcon(Icons.cancel),
                label: Text(Language.getText('no'), style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
            ],
          ),
    );
  }
}
class UIStaffSelect extends StatefulWidget
{
  const UIStaffSelect({Key? key, required this.staffsSelect,
                                 required this.titleAction
                                 }): super(key: key);
  final  List<Staff> staffsSelect;
  final String titleAction;
  @override
  _UIStaffSelect createState() => _UIStaffSelect();

}

class _UIStaffSelect extends State<UIStaffSelect>
{
  @override
  void initState() {
    super.initState();
  }
  void refreshSelect()
  {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child:  TextButton.icon(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => UserViewDialog(staffsSelect: this.widget.staffsSelect, refreshSelect: this.refreshSelect),
                      fullscreenDialog: true,
                    ));
              },
                  style: UIUtils.setButtonUserStyle(),
                  icon: UIUtils.setButtonIcon(Icons.supervised_user_circle_rounded),
                  label: UIUtils.setButtonText(this.widget.titleAction)
              ),
              padding: UIUtils.paddingLite
            ),
            Container(
              child:  TextButton.icon(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => UserGroupViewDialog(staffsSelect: this.widget.staffsSelect, refreshSelect: this.refreshSelect),
                      fullscreenDialog: true,
                    ));
              },
                  style: UIUtils.setButtonUserGroupStyle(),
                  icon: UIUtils.setButtonIcon(Icons.supervised_user_circle_rounded),
                  label: UIUtils.setButtonText(Language.getText('select_workgroup'))
              ),
              padding: UIUtils.paddingLite,
            )

          ],
        )
        ,
        SizedBox(
          child:  Card(
              child:  new Builder(
                  builder: (BuildContext context1) =>  this.widget.staffsSelect.length !=0 ?
                  Container(
                      padding: UIUtils.paddingForm,
                      height: MediaQuery.of(context1).size.height * 0.09,
                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: this.widget.staffsSelect.isNotEmpty ? this.widget.staffsSelect.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return
                              ListTile(
                                title: Container(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        UIUtils.setTextUserName(this.widget.staffsSelect[index].fullName ),
                                      ]),
                                ) ,
                                subtitle:  Container(

                                  child: Row(
                                      children: [
                                        UIUtils.getIconLevel(),
                                        UIUtils.setDescriptionLevel(this.widget.staffsSelect[index].chucVuItem.tenChucVu+ '-'+ this.widget.staffsSelect[index].donViItem.tenCQ)
                                      ]
                                  ),
                                ),

                                trailing: IconButton(onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text(Language.getText('alert')),
                                          content: Text(Language.getText('question_delete_user')),
                                          actions: <Widget>[
                                            TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                this.setState(() {
                                                  this.widget.staffsSelect.removeAt(index);
                                                });
                                              },
                                              style: UIUtils.setButtonResetStyle(),
                                              icon: UIUtils.setButtonIcon(
                                                  Icons.check_circle_outline_outlined),
                                              label: Text(Language.getText('yes'), style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                            ),
                                            TextButton.icon(
                                              onPressed: () => Navigator.pop(context),
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.red)),
                                              icon: UIUtils.setButtonIcon(Icons.cancel),
                                              label: Text(Language.getText('no'), style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                  );

                                },
                                  icon:UIUtils.setButtonRemoveUserIcon(Icons.dangerous),

                                ) ,
                              );

                          }
                      )
                  )
                      : new Container()

              )
          ),
          height: this.widget.staffsSelect.length>1?250:80
        )


      ],
    );

  }
}

class UIColor {
  UIColor(this.callActionCommand);
  final Function(Color color) callActionCommand;
  Color colorPicker= Colors.red;
  void changeColor(Color color) {
    colorPicker = color;
  }
  void showDialogColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(Language.getText('select_color')),
            content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: colorPicker,
                  onColorChanged: changeColor,
                )
            ),
            actions: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  callActionCommand(colorPicker);
                },
                style: UIUtils.setButtonResetStyle(),
                icon: UIUtils.setButtonIcon(
                    Icons.check_circle_outline_outlined),
                label: Text(Language.getText('yes'), style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                icon: UIUtils.setButtonIcon(Icons.cancel),
                label: Text(Language.getText('no'), style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ),
            ],
          ),
    );
  }
}
class UICalendarEvent extends StatefulWidget
{
  const UICalendarEvent({Key? key,
    required this.eventCalendarDataSource,
    required this.callMethodDetail,
    required this.loadDataSource
  }): super(key: key);
  final  EventCalendarDataSource eventCalendarDataSource;

  final Function(int id) callMethodDetail;
  final Function( int month, int year) loadDataSource;

  @override
  _UICalendarEvent createState() => _UICalendarEvent();

}
class _UICalendarEvent extends State<UICalendarEvent>
{
  var _calendarController= new   CalendarController();
  @override
  void initState() {
    super.initState();

  }
  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance!.addPostFrameCallback((Duration duration) {
      this._calendarController.selectedDate = viewChangedDetails.visibleDates[0];
            this.widget.loadDataSource(this._calendarController.selectedDate!.month,this._calendarController.selectedDate!.year);
      setState(() {
              this.widget.eventCalendarDataSource;
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      dataSource: this.widget.eventCalendarDataSource,
      controller: this._calendarController,
      onViewChanged: viewChanged,
      allowedViews: [
        CalendarView.month,
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.timelineDay,
        CalendarView.timelineWeek,
        CalendarView.timelineWorkWeek,
        CalendarView.schedule,
        CalendarView.timelineMonth
      ],
      appointmentTimeTextFormat: 'HH:mm',

      timeSlotViewSettings: TimeSlotViewSettings(
        timeFormat: ' HH:mm',
        dateFormat: 'dd',
        dayFormat: 'EEE',

      ),
      firstDayOfWeek: 1,
      monthViewSettings: MonthViewSettings(
          showAgenda: true
      ),
      onTap: (CalendarTapDetails details) {
        DateTime date = details.date!;
        CalendarElement element = details.targetElement;
        if (details.targetElement == CalendarElement.appointment) {
          List<dynamic>? appointment = details.appointments;
          if(appointment!=null && appointment.length>0)
          {
            EventCalendar me= appointment[0];
            this.widget.callMethodDetail(me.id);
          }
        }
      },
    );

  }
}

class UIPickerColorAction extends StatefulWidget
{
  const UIPickerColorAction({Key? key, required this.colorPicker, required this.colorDefault}): super(key: key);
  final Function(Color color) colorPicker;
  final Color colorDefault;

  @override
  _UIPickerColorAction createState() => _UIPickerColorAction();
}
class _UIPickerColorAction extends State<UIPickerColorAction>
{
  Color colorDefault=Colors.red;
  @override
  void initState(){
    super.initState();
    this.colorDefault = this.widget.colorDefault;
  }
  void callColorPicker(Color color)
  {
      this.widget.colorPicker(color);
      setState(() {
        this.colorDefault=color;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton.icon(onPressed: () async {
              new UIColor(callColorPicker).showDialogColor(context);
            },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(this.colorDefault)),
                icon: UIUtils.setButtonIcon(Icons.color_lens_outlined),
                label: UIUtils.setButtonText(Language.getText("select_color")
                )
            ),

          ],
        )

      ],
    );

  }
}

class UIBadgeAction extends StatefulWidget
{
  const UIBadgeAction({Key? key,
    required this.value,
    required this.tooltip,
    required this.icon,
    required this.actionCommand
    }) : super(key: key);


  final String value;
  final String tooltip;
  final IconData icon;
  final Function() actionCommand;

  @override
  _UIBadgeActionState createState() => _UIBadgeActionState();
}
class _UIBadgeActionState extends State<UIBadgeAction>
{
  @override
  Widget build(BuildContext context) {
    return Badge(
        position: BadgePosition.topEnd(top:-4, end:0),
        animationDuration: Duration(milliseconds: 300),
        badgeColor: Colors.red,
        animationType: BadgeAnimationType.slide,
        badgeContent: UIUtils.setTextNotification(this.widget.value),
        child: IconButton(
          icon: UIUtils.getIconDashBoard(this.widget.icon),
          padding: new EdgeInsets.fromLTRB(0,0,0,30.0),
          tooltip: this.widget.tooltip,
          onPressed: () {
              this.widget.actionCommand();
          },
        )
    );
  }
}