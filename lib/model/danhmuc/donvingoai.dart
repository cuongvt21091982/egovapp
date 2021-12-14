class DonViNgoai
{
  final int id ;
  final String tenCQ;
  final String tenVietTat;
  final int cap;
  final int maCapTren;
  final String ngayThanhLap;
  final String diaChi;
  final String dienThoai;
  final String soFax;
  final String email;
  final String diaChiWeb;
  final int maLinhVucHoatDong;
  final int maNhomDoiTac;
  final String lichSuQuanHe;
  final String ngayBatDauHopTac;
  final int hienThi;
  final int stt;
  final int suDung;
  final bool hasChild;
  DonViNgoai({
    required this.id ,
    required this.tenCQ,
    required this.tenVietTat,
    required this.cap,
    required this.maCapTren,
    required this.ngayThanhLap,
    required this.diaChi,
    required this.dienThoai,
    required this.soFax,
    required this.email,
    required this.diaChiWeb,
    required this.maLinhVucHoatDong,
    required this.maNhomDoiTac,
    required this.lichSuQuanHe,
    required this.ngayBatDauHopTac,
    required this.hienThi,
    required this.stt,
    required this.suDung,
    required this.hasChild
  });
  factory DonViNgoai.fromJson(Map<String, dynamic>? json) {
    return DonViNgoai(
        id: json != null && json['id']!=null ? json['id'] :0 ,
        tenCQ: json != null && json['tenCQ']!=null ? json['tenCQ'] :'',
        tenVietTat: json!= null && json['tenVietTat']!=null ? json['tenVietTat'] :'',
        cap: json != null && json['cap']!=null ? json['cap'] :0,
        maCapTren: json != null && json['maCapTren']!=null ? json['maCapTren'] :0,
        ngayThanhLap: json != null && json['ngayThanhLap']!=null ? json['ngayThanhLap'] :'',
        diaChi: json != null && json['diaChi']!=null ? json['diaChi'] :'',
        dienThoai: json != null && json['dienThoai']!=null ? json['dienThoai'] :'',
        soFax: json != null && json['soFax']!=null ? json['soFax'] :'',
        email: json != null && json['email']!=null ? json['email'] :'',
        diaChiWeb: json != null && json['diaChiWeb']!=null ? json['diaChiWeb'] :'',
        maLinhVucHoatDong: json != null && json['maLinhVucHoatDong']!=null ? json['maLinhVucHoatDong'] :0,
        maNhomDoiTac: json != null && json['maNhomDoiTac']!=null ? json['maNhomDoiTac'] :0,
        lichSuQuanHe: json != null && json['lichSuQuanHe']!=null ? json['lichSuQuanHe'] :'',
        ngayBatDauHopTac: json != null && json['ngayBatDauHopTac']!=null ? json['ngayBatDauHopTac'] :'',
        hienThi: json != null && json['hienThi']!=null ? json['hienThi'] :0,
        stt: json != null && json['stt']!=null ? json['stt'] :0,
        suDung: json != null && json['suDung']!=null ? json['suDung'] :0,
        hasChild: json != null && json['hasChild']!=null ? json['hasChild'] :false
    );
  }
}
