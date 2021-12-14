class LoaiPhong
{
  final int id;
  final String tenLoaiPhong;
  LoaiPhong({
    required this.id,
    required this.tenLoaiPhong
  });
  factory LoaiPhong.fromJson(Map<String, dynamic>? json) {
    return LoaiPhong(
        id: json != null ? json['id'] : -1,
        tenLoaiPhong: json != null && json['tenLoaiPhong']!=null? json['tenLoaiPhong']: ''

    );
  }
}
