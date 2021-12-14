class SoVanThuDV
{
  final int id;
  final int soVanThuID ;
  final int maDonVi;

  SoVanThuDV({
    required this.id,
    required this.soVanThuID,
    required this.maDonVi
  });
  factory SoVanThuDV.fromJson(Map<String, dynamic>? json) {
    return SoVanThuDV(
        id: json!= null ? json['id'] : -1,
        soVanThuID: json!= null && json['soVanThuID'] != null ? json['soVanThuID'] : 0,
        maDonVi: json!= null && json['maDonVi'] != null ? json['maDonVi'] : 0
    );
  }
}
