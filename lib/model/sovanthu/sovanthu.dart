class SoVanThu
{
  final int id;
  final String tenSoVanThu ;
  final int soVaoSo;
  final String kyHieuVanBan;
  final int suDung;
  final int stt;
  final int doKhan;
  final int doMat;
  SoVanThu({
    required this.id,
    required this.tenSoVanThu,
    required this.soVaoSo,
    required this.kyHieuVanBan,
    required this.suDung,
    required this.stt,
    required this.doKhan,
    required this.doMat
  });
  factory SoVanThu.fromJson(Map<String, dynamic>? json) {
    return SoVanThu(
        id: json!= null ? json['id'] : -1,
        tenSoVanThu: json!= null && json['tenSoVanThu'] != null ? json['tenSoVanThu'] : '',
        soVaoSo: json!= null && json['soVaoSo'] != null ? json['soVaoSo'] : 0,
        kyHieuVanBan: json!= null && json['kyHieuVanBan'] != null ? json['kyHieuVanBan'] : '',
        stt: json!= null && json['stt'] != null ? json['stt'] : 0,
        suDung: json!= null  ? json['suDung'] : -1,
        doKhan: json!= null?  json['doKhan'] : -1,
        doMat: json!= null?  json['doMat'] : -1
    );
  }
}
