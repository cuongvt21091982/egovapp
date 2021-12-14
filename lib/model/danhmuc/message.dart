class Message
{
  final bool status;
  final String content;
  Message({
    required this.status,
    required this.content

  });
  factory Message.fromJson(Map<String, dynamic>? json) {
    return Message(
      status: json!= null && json['status']!=null ? json['status']: false,
      content: json!= null && json['content']!=null? json['content']: '',
    );
  }
}
