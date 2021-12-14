class DataWeek
{
  final int id;
  final String title;
  DataWeek({
    required this.id,
    required this.title
  });
  factory DataWeek.fromJson(Map<String, dynamic>? json) {
    return DataWeek(
        id: json!= null && json['id'] != null? json['id']: 0,
        title: json!= null &&  json['title'] != null? json['title']: ''
    );
  }
}