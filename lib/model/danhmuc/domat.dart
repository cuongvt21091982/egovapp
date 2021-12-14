class DoMat
{
  final int id;
  final String tenDoMat;
  DoMat({
    required this.id,
    required this.tenDoMat

  });
  factory DoMat.fromJson(Map<String, dynamic>? json) {

    return DoMat(
      id: json!= null ? json['id'] : -1,
      tenDoMat: json!= null && json['tenDoMat']!=null? json['tenDoMat']: '',
    );
  }
}
