class ToaNha
{
  final int id;
  final String tenToaNha;
  ToaNha({
    required this.id,
    required this.tenToaNha
  });
  factory ToaNha.fromJson(Map<String, dynamic>? json) {
    return ToaNha(
        id: json != null ? json['id'] : -1,
        tenToaNha: json != null && json['tenToaNha']!=null? json['tenToaNha']: ''

    );
  }
}
