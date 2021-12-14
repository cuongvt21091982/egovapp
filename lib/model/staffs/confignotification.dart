class ConfigNotification
{
  final String  apiKey;
  final String  appId;
  final String  messagingSenderId;
  final String  projectId;
  final String  subcriber;
  ConfigNotification(
      {
        required this.apiKey,
        required this.appId,
        required this.messagingSenderId,
        required this.projectId,
        required this.subcriber
      });
  factory ConfigNotification.fromJson(Map<String, dynamic>? json) {
    return ConfigNotification(
      apiKey: json!= null && json['apiKey'] != null? json['apiKey']: '',
      appId: json!= null && json['appId'] != null? json['appId']: '',
      messagingSenderId: json!= null && json['messagingSenderId'] != null? json['messagingSenderId']: '',
      projectId: json!= null && json['projectId'] != null? json['projectId']: '',
      subcriber: json!= null && json['subcriber'] != null? json['subcriber']: '',
    );
  }
}