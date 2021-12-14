class LoaiVanBan
{
  final int id;
  final String tenLoaiVanBan;
  final int stt;
  LoaiVanBan({
    required this.id,
    required this.tenLoaiVanBan,
    required this.stt

  });
  factory LoaiVanBan.fromJson(Map<String, dynamic>? json) {
    return LoaiVanBan(
        id: json != null ? json['id'] : -1,
        tenLoaiVanBan: json != null && json['tenLoaiVanBan']!=null? json['tenLoaiVanBan']: '',
        stt: json != null ? json['stt'] : -1
    );
  }
}
