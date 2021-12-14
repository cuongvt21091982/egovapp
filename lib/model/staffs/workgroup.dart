class WorkGroup
{
  final int  id;
  final String  tenNhom;
  final int beLongTo;
  final int  groupType;
  final int stt;
  WorkGroup(
  {
    required this.id,
    required this.tenNhom,
    required this.beLongTo,
    required this.groupType,
    required this.stt

  });
  factory WorkGroup.fromJson(Map<String, dynamic>? json) {

    return WorkGroup(
        id: json!= null && json['id'] != null? json['id']: 0,
        tenNhom: json!= null && json['tenNhom'] != null? json['tenNhom']: '',
        beLongTo: json!= null && json['beLongTo'] != null? json['beLongTo']: -1,
        groupType: json!= null && json['groupType'] != null? json['groupType']: -1,
        stt: json!= null && json['stt'] != null? json['stt']: -1
    );
  }
}