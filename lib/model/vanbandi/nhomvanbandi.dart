class NhomVanBanDi
{
  final int id;
  final String tenNhomVBDi ;
  final int soKhoiTaoVB;
  final String duoiSoKhoiTao;
  final int soVanThuID;
  final String logUpdate;
  final int suDung;
  NhomVanBanDi({
    required this.id,
    required this.tenNhomVBDi,
    required this.soKhoiTaoVB,
    required this.duoiSoKhoiTao,
    required this.soVanThuID,
    required this.logUpdate,
    required this.suDung
  });
  factory NhomVanBanDi.fromJson(Map<String, dynamic>? json) {
    return NhomVanBanDi(
        id: json!= null ? json['id'] : -1,
        tenNhomVBDi: json!= null && json['tenNhomVBDi'] != null ? json['tenNhomVBDi'] : '',
        soKhoiTaoVB: json!= null && json['soKhoiTaoVB'] != null ? json['soKhoiTaoVB'] : 0,
        duoiSoKhoiTao: json!= null && json['duoiSoKhoiTao'] != null ? json['duoiSoKhoiTao'] : '',
        soVanThuID: json!= null  ? json['soVanThuID'] : -1,
        logUpdate: json!= null && json['logUpdate'] != null ? json['logUpdate'] : '',
        suDung: json!= null?  json['suDung'] : -1
    );
  }
}
