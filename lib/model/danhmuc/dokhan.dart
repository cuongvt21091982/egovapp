class DoKhan
{
  final int id;
  final String tenDoKhan;
  DoKhan({
    required this.id,
    required this.tenDoKhan

  });
  factory DoKhan.fromJson(Map<String, dynamic> json) {
    return DoKhan(
        id: json!= null ? json['id']: -1,
        tenDoKhan: json!= null && json['tenDoKhan']!=null? json['tenDoKhan']: '',
    );
  }
}
