class NavItem
{
  final int id;
  final String  code;
  final String  name;
  final int  type;
  final int  parentId;
  NavItem(
      {
        required this.id,
        required this.code,
        required this.name,
        required this.type,
        required this.parentId
      });
  factory NavItem.fromJson(Map<String, dynamic>? json) {
    return NavItem(
      id: json!= null && json['id'] != null? json['id']: 0,
      code: json!= null && json['code'] != null? json['code']: '',
      name: json!= null && json['name'] != null? json['name']: '',
      type: json!= null && json['type'] != null? json['type']: 0,
      parentId: json!= null && json['parentId'] != null? json['parentId']: 0,
    );
  }
}