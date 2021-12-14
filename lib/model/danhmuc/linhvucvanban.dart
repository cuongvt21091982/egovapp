class LinhVucVanBan
{
  final int id;
  final String tenLinhVuc;
  final int stt;
  LinhVucVanBan({
    required this.id,
    required this.tenLinhVuc,
    required this.stt

  });
  factory LinhVucVanBan.fromJson(Map<String, dynamic>? json) {
    return LinhVucVanBan(
      id: json != null ? json['id'] : -1,
      tenLinhVuc: json != null && json['tenLinhVuc']!=null? json['tenLinhVuc']: '',
        stt: json != null ? json['stt']: -1
    );
  }
}
