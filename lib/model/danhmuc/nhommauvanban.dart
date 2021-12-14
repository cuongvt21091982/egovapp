class NhomMauVanBan
{
  final int id;
  final String ten;
  NhomMauVanBan({
    required this.id,
    required this.ten
  });
  factory NhomMauVanBan.fromJson(Map<String, dynamic>? json) {
    return NhomMauVanBan(
        id: json != null ? json['id'] : -1,
        ten: json != null && json['ten']!=null? json['ten']: ''

    );
  }
}
