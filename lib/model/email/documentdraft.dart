
import 'package:egovapp/model/email/documentdraftfile.dart';


class DocumentDraft
{
  final int id;
  final String chuDe;
  final String noiDung;
  final String thoiHan;
  final String thoiGianNhap;
  final int beLongToID;
  final String lstReceiveUsers;
  final String docType;
  final int replyId;
  List<DocumentDraftFile> documentDraftFiles;
  DocumentDraft({
    required this.id,
    required this.chuDe,
    required this.noiDung,
    required this.thoiHan,
    required this.thoiGianNhap,
    required this.beLongToID,
    required this.lstReceiveUsers,
    required this.docType,
    required this.replyId,
    required this.documentDraftFiles
  });
  factory DocumentDraft.fromJson(Map<String, dynamic>? json) {
    return DocumentDraft(
        id: json!= null && json['id'] != null? json['id']: 0,
        chuDe: json!= null &&  json['chuDe'] != null? json['chuDe']: '',
        noiDung: json!= null &&  json['noiDung'] != null? json['noiDung']: '',
        thoiHan: json!= null &&  json['thoiHan'] != null? json['thoiHan']: '',
        thoiGianNhap: json!= null &&  json['thoiGianNhap'] != null? json['thoiGianNhap']: '',
        beLongToID: json!= null &&  json['beLongToID'] != null? json['beLongToID']: 0,
        lstReceiveUsers: json!= null &&  json['lstReceiveUsers'] != null? json['lstReceiveUsers']: '',
        docType: json!= null &&  json['docType'] != null? json['docType']: '',
        replyId: json!= null &&  json['replyId'] != null? json['replyId']: '',
        documentDraftFiles: json!= null &&  json['documentDraftFiles']!=null? (json['documentDraftFiles'] as List)
            .map((data) => DocumentDraftFile.fromJson(data))
            .toList(): []
    );
  }
}