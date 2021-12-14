class Users
{
  final int  id;
  final int  staffID;
  final String userName;
  final String  password;
  final String roleName;

  Users(
      {
        required this.id,
        required this.staffID,
        required this.userName,
        required this.password,
        required this.roleName


      });
  factory Users.fromJson(Map<String, dynamic>? json) {

    return Users(
      id: json!= null && json['id'] != null? json['id']: 0,
      password: json!= null && json['password'] != null? json['password']: '',
      userName: json!= null && json['userName'] != null? json['userName']: '',
      staffID: json!= null && json['staffID'] != null? json['staffID']: 0,
      roleName: json!= null && json['roleName'] != null? json['roleName']: '',
    );
  }
}