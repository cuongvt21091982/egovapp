class ThietBi
{
  final int id;
  final String tenThietBi;
  final int loaiPhongID;
  final int toaNhaID;
  final String sucChua;
  final String ghiChu;
  final int stt;
  ThietBi({
    required this.id,
    required this.tenThietBi,
    required this.loaiPhongID,
    required this.toaNhaID,
    required this.sucChua,
    required this.ghiChu,
    required this.stt

  });
  factory ThietBi.fromJson(Map<String, dynamic>? json) {
    return ThietBi(
        id: json != null ? json['id'] : -1,
        tenThietBi: json != null && json['tenThietBi']!=null? json['tenThietBi']: '',
        loaiPhongID: json != null && json['loaiPhongID']!=null? json['loaiPhongID']: 0,
        toaNhaID: json != null && json['toaNhaID']!=null? json['toaNhaID']: 0,
        sucChua: json != null && json['sucChua']!=null? json['sucChua']: '',
        ghiChu: json != null && json['ghiChu']!=null? json['ghiChu']: '',
        stt: json != null ? json['stt']: -1
    );
  }
}
