class SessionToken
{
  final int  userId;
  final int  maDonVi;
  final int staffId;
  final String  token;
  SessionToken(
      {
        required this.userId,
        required this.maDonVi,
        required this.staffId,
        required this.token
      });
  factory SessionToken.fromJson(Map<String, dynamic>? json) {
    return SessionToken(
        userId: json!= null && json['userId'] != null? json['userId']: 0,
        token: json!= null && json['token'] != null? json['token']: '',
        maDonVi: json!= null && json['maDonVi'] != null? json['maDonVi']: 0,
        staffId: json!= null && json['staffId'] != null? json['staffId']: 0,
    );
  }
}