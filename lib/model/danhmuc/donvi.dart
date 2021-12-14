class DonVi
{
  final int id;
  final String tenCQ;
  final String tenVietTat;
  final int cap;
  final int maCapTren;
  final int stt;
  final int suDung;
  final bool hasChild;
  DonVi({
    required this.id,
    required this.tenCQ,
    required this.tenVietTat,
    required this.cap,
    required this.maCapTren,
    required this.stt,
    required this.suDung,
    required this.hasChild,

  });
  factory DonVi.fromJson(Map<String, dynamic>? json) {

    return DonVi(
      id: json!= null ? json['id']: 0,
      tenCQ: json!= null && json['tenCQ']!=null? json['tenCQ']: '',
      tenVietTat: json!= null &&  json['tenVietTat']!=null? json['tenVietTat']: '',
      cap: json!= null &&  json['cap']!=null? json['cap']: 0,
      maCapTren: json!= null &&  json['maCapTren']!=null? json['maCapTren']: 0,
      stt: json!= null &&  json['stt']!=null? json['stt']: 0,
      suDung: json!= null &&  json['suDung']!=null? json['suDung']: 0,
      hasChild: json!= null &&  json['hasChild']!=null? json['hasChild']: false,
    );
  }
}
