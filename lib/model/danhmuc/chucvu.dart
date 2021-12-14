class ChucVu
{
  final int id;
  final String tenChucVu ;
  final String tenVietTat;
  final int baoCao;
  final int stt;
  ChucVu({
    required this.id,
    required this.tenChucVu,
    required this.tenVietTat,
    required this.baoCao,
    required this.stt
  });
  factory ChucVu.fromJson(Map<String, dynamic>? json) {
      return ChucVu(
          id: json!= null ? json['id'] : -1,
          tenChucVu: json!= null && json['tenChucVu'] != null ? json['tenChucVu'] : '',
          tenVietTat: json!= null && json['tenVietTat'] != null ? json['tenVietTat'] : '',
          baoCao: json!= null  ? json['baoCao'] : -1,
          stt: json!= null?  json['stt'] : -1
      );
  }
}
