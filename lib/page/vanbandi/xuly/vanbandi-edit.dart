import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/danhmuc/dokhan.dart';
import 'package:egovapp/model/danhmuc/domat.dart';
import 'package:egovapp/model/danhmuc/donvingoai.dart';
import 'package:egovapp/model/danhmuc/linhvucvanban.dart';
import 'package:egovapp/model/danhmuc/loaivanban.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/vanbandi/nhomvanbandi.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/danhmuc/service-dokhan.dart';
import 'package:egovapp/service/danhmuc/service-domat.dart';
import 'package:egovapp/service/danhmuc/service-donvingoai.dart';
import 'package:egovapp/service/danhmuc/service-linhvucvanban.dart';
import 'package:egovapp/service/danhmuc/service-loaivanban.dart';

import 'package:egovapp/service/vanbanden/service-vanbandenfile.dart';
import 'package:egovapp/service/vanbandi/service-nhomvanbandi.dart';
import 'package:egovapp/service/vanbandi/service-vanbandi.dart';
import 'package:egovapp/service/vanbandi/service-vanbandifile.dart';
import 'package:egovapp/service/vanbandi/service-vanbandinoinhan.dart';
import 'package:flutter/material.dart';
class EditVanBanDi extends StatefulWidget
{
  const EditVanBanDi({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditVanBanDiState createState() => _EditVanBanDiState();}
class _EditVanBanDiState extends State<EditVanBanDi>
{
  TextEditingController  txtSoVaoSo =  TextEditingController();
  TextEditingController  txtTrichYeu =  TextEditingController();
  TextEditingController  txtGhiChu =  TextEditingController();
  var  dtNgayVaoSo =  TextEditingController();
  var  dtNgayKy =  TextEditingController();
  LoaiVanBan? maLoaiVB;
  LinhVucVanBan? maLinhVuc;
  DoMat? maDoMat;
  DoKhan? maDoKhan;
  NhomVanBanDi? maNhomVBDi;
  List<DonViNgoai> donViNgoaiList=[];
  int maNguoiChuTri = ParamUtils.valueDefault;
  List<Staff> staffsSelect = [];
  List<FileItem> fileUploads= [];
  int status = ParamUtils.statusDraft;
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceVanBanDi().getById(this.widget.id).then((value) {
        this.status = value.maTrangThaiXL;
        this.txtTrichYeu.value = new TextEditingValue(text: value.trichYeu );
        this.txtGhiChu.value = new TextEditingValue(text: value.ghiChu );
        this.txtSoVaoSo.value = new TextEditingValue(text: value.soVaoSo );
        this.staffsSelect.add(value.nguoiKy);
        this.dtNgayVaoSo.value = TextEditingValue(text: value.ngayVaoSo);
        this.dtNgayKy.value = TextEditingValue(text: value.ngayKy);
        if(value.maNhomVBdi !=0)
          ServiceNhomVanBanDi().getById(value.maNhomVBdi).then((value) {
            maNhomVBDi=value;
          })..catchError((onError) {
            UIUtils.showToastError(onError.toString(), context);
          });

        if(value.maLoaiVB !=0)
          ServiceLoaiVanBan().getById(value.maLoaiVB).then((value) {
            maLoaiVB=value;
          })..catchError((onError) {
            UIUtils.showToastError(onError.toString(), context);
          });
        if(value.maLinhVuc !=0)
          ServiceLinhVucVanBan().getById(value.maLinhVuc).then((value) {
            maLinhVuc=value;
          })..catchError((onError) {
            UIUtils.showToastError(onError.toString(), context);
          });
        if(value.maDoMat !=0)
          ServiceDoMat().getById(value.maDoMat).then((value) {
            maDoMat=value;
          })..catchError((onError) {
            UIUtils.showToastError(onError.toString(), context);
          });
        if(value.maDoKhan !=0)
          ServiceDoKhan().getById(value.maDoKhan).then((value) {
            maDoKhan=value;
          })..catchError((onError) {
            UIUtils.showToastError(onError.toString(), context);
          });
        ServiceVanBanDiNoiNhan().getAllByVanBanId(value.id).then((value) {
          for (var f in value)
            donViNgoaiList.add(f.noiNhan);
        })..catchError((onError) {
          UIUtils.showToastError(onError.toString(), context);
        });
        if (value.vanBanDiFiles.length > 0) {
          for (var f in value.vanBanDiFiles)
            this.fileUploads.add(new FileItem(id: f.id,
                key: f.fileKey,
                name: f.name,
                path: f.folder,
                action: true));
        }
        setState((){

        });
      }).catchError((onError) {
        UIUtils.showToastError(onError.toString(), context);
      });
    }
  }
  Future<void> deleteFile(FileItem fileItem)
  async {
    if(fileItem.action == false)
    {
      setState(() {
        fileUploads.remove(fileItem);
      });
    }
    else
    {
      final dialogContextCompleter = UIUtils.progressAction(context);
      final dialogContext = await dialogContextCompleter.future;
      ServiceVanBanDiFile().delete(fileItem.id).then((value) {
        Navigator.pop(dialogContext, true);
        setState(() {
          fileUploads.remove(fileItem);
        });
      }).catchError((e){
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      }
      );
    }
  }
  Future<List<LoaiVanBan>> selectLoaiVanBan(String? filter)
  {
    return ServiceLoaiVanBan().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }
  Future<List<DoMat>> selectDoMat(String? filter)
  {
    return ServiceDoMat().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }
  Future<List<DoKhan>> selectDoKhan(String? filter)
  {
    return ServiceDoKhan().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }
  Future<List<LinhVucVanBan>> selectLinhVuc(String? filter)
  {
    return ServiceLinhVucVanBan().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }
  Future<List<DonViNgoai>> selectDonViNgoai(String? filter)
  {
    return ServiceDonViNgoai().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax)..catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }
  Future<List<NhomVanBanDi>> selectNhomVanBanDi(String? filter)
  {
    return ServiceNhomVanBanDi().getPaging(filter!).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }
  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    if(this.widget.id ==0) {
      ServiceVanBanDi().add(
          this.donViNgoaiList.map((e) => e.id).toList().join(','),
          this.txtSoVaoSo.text,
          this.maNhomVBDi?.id ?? 0,
          this.maLoaiVB!.id,
          this.txtTrichYeu.text,
          (this.maLinhVuc?.id ?? 0),
          this.maDoMat?.id ?? 0,
          this.maDoKhan?.id ?? 0,
          this.dtNgayKy.text,
          this.dtNgayVaoSo.text,
          this.txtGhiChu.text,
          this.staffsSelect[0].id,
          UserAuthSession.staffId,
          maNguoiChuTri,
          status
         ).then((value) {
        UIUtils.showToastSuccess(
            status == ParamUtils.statusChuaXuLy ? Language.getText(
                'message_send_success') : Language.getText('message_insert_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceVanBanDenFile().add(value.id, f.path!);
          }
        }
        Navigator.pop(dialogContext, true);
        this.widget.callBackRefresh();
        Navigator.pop(context, true);
      })..catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
    }else
    {
      ServiceVanBanDi().update(this.widget.id,
          this.donViNgoaiList.map((e) => e.id).toList().join(','),
          this.txtSoVaoSo.text,
          this.maNhomVBDi?.id ?? 0,
          this.maLoaiVB!.id,
          this.txtTrichYeu.text,
          (this.maLinhVuc?.id ?? 0),
          this.maDoMat?.id ?? 0,
          this.maDoKhan?.id ?? 0,
          this.dtNgayKy.text,
          this.dtNgayVaoSo.text,
          this.txtGhiChu.text,
          this.staffsSelect[0].id,
          UserAuthSession.staffId,
          maNguoiChuTri,
          status).then((value) {
        UIUtils.showToastSuccess(
            status == ParamUtils.statusChuaXuLy ? Language.getText(
                'message_send_success') : Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceVanBanDiFile().add(value.id, f.path!);
          }
        }
        Navigator.pop(dialogContext, true);
        this.widget.callBackRefresh();
        Navigator.pop(context, true);
      })..catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
    }
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
              child: UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoiky')) ,
              padding: UIUtils.paddingForm,
            )
            ,
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtSoVaoSo,TextInputType.text,
                    Language.getText('sovaoso'), Language.getText('sovaoso'), true, Language.getText('sovaoso')+Language.getText('required_empty'))
            ),Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtTrichYeu,TextInputType.multiline,
                    Language.getText('trichyeu'), Language.getText('trichyeu'), true, Language.getText('trichyeu')+Language.getText('required_empty'))
            ),Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<NhomVanBanDi>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: maNhomVBDi,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('nhomvanban'), Language.getText('select_nhomvanban'),false),
                    onFind: (String? filter) => selectNhomVanBanDi(filter),
                    itemAsString: (NhomVanBanDi? u) => u!.tenNhomVBDi,
                    onChanged: (data) {
                      this.maNhomVBDi = data;
                    }

                )
            ),Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<DonViNgoai>.multiSelection(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    items: donViNgoaiList,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('donvinhan'), Language.getText('select_donvinhan'),true),
                    onFind: (String? filter) => selectDonViNgoai(filter),
                    itemAsString: (DonViNgoai? u) => u!.tenCQ,
                    onChange: (data) {
                      this.donViNgoaiList = data;
                    },
                    validator: (value) {
                      if(value == null)
                        return Language.getText('select_empty') + Language.getText('donvinhan').toLowerCase();
                      return null;
                    }

                )
            ),Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<LoaiVanBan>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: maLoaiVB,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('loaivanban'), Language.getText('select_loaivanban'),true),
                    onFind: (String? filter) => selectLoaiVanBan(filter),
                    itemAsString: (LoaiVanBan? u) => u!.tenLoaiVanBan,
                    onChanged: (data) {
                      this.maLoaiVB = data;
                    },
                    validator: (value) {
                      if(value == null)
                        return Language.getText('select_empty') + Language.getText('loaivanban').toLowerCase();
                      return null;
                    }

                )
            )
            ,Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<LinhVucVanBan>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: this.maLinhVuc,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('linhvucvanban'), Language.getText('select_linhvucvanban'),false),
                    onFind: (String? filter) => selectLinhVuc(filter),
                    itemAsString: (LinhVucVanBan? u) => u!.tenLinhVuc,
                    onChanged: (data) {
                      this.maLinhVuc = data;
                    }

                )
            )
            ,Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<DoMat>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: maDoMat,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('domat'), Language.getText('select_domat'),false),
                    onFind: (String? filter) => selectDoMat(filter),
                    itemAsString: (DoMat? u) => u!.tenDoMat,
                    onChanged: (data) {
                      this.maDoMat = data;
                    }

                )
            )
            ,Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<DoKhan>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: maDoKhan,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('dokhan'), Language.getText('select_dokhan'),false),
                    onFind: (String? filter) => selectDoKhan(filter),
                    itemAsString: (DoKhan? u) => u!.tenDoKhan,
                    onChanged: (data) {
                      this.maDoKhan = data;
                    }

                )
            ) ,
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtNgayKy,
                    title:Language.getText('ngayky'),
                    description: Language.getText('ngayky'),
                    validate: true,
                    messageRequired: Language.getText('ngayky') + Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtNgayVaoSo,
                    title:Language.getText('ngayvaoso'),
                    description: Language.getText('ngayvaoso'),
                    validate: true,
                    messageRequired: Language.getText('ngayvaoso') + Language.getText('required_empty'))
            ),Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtGhiChu,TextInputType.multiline,
                    Language.getText('ghichu'), Language.getText('ghichu'), false, '')
            ),
            Container(
                padding: UIUtils.paddingForm,
                child: AttachFileFormAction(fileUploads: fileUploads, deleteFile: deleteFile)
            ),Container(
                alignment: Alignment.topLeft,
                padding: UIUtils.paddingForm,
                child: UIUtils.getNoteRequired()
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: UIUtils.paddingLite,
                        child: TextButton.icon(onPressed: () async{
                          if(this.staffsSelect.length == 0)
                            UIUtils.showToastError(Language.getText("message_error_assiger"), context);
                          else
                          if(this.donViNgoaiList.length == 0)
                            UIUtils.showToastError(Language.getText("message_error_donvinhan"), context);
                          else {
                            if (formKey.currentState!.validate()) {
                              UIAction(actionForm).showDialogConfirm(context,
                                  Language.getText('message_save_question'));
                            }
                          }
                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("draft")
                          ),

                        )
                    )
                    ,
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton.icon(onPressed: () async {
                          if(this.staffsSelect.length == 0)
                            UIUtils.showToastError(Language.getText("message_error_assiger"), context);
                          else
                          if(this.donViNgoaiList.length == 0)
                            UIUtils.showToastError(Language.getText("message_error_donvinhan"), context);
                          else
                            {
                              if (formKey.currentState!.validate()) {
                                this.status = ParamUtils.statusChoGiaoXuLy;
                                UIAction(actionForm).showDialogConfirm(context, Language.getText('message_send_question'));
                              }
                            }
                        },
                          style:UIUtils.setButtonConfirmStyle(),
                          icon: UIUtils.setButtonIcon(Icons.send) ,
                          label: UIUtils.setButtonResetText(Language.getText("send")
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
