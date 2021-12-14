import 'package:egovapp/model/danhmuc/donvingoai.dart';

class VanBanDiNoiNhan
{
  final int id;
  final int maVB ;
  final int maNoiNhan;
  final DonViNgoai noiNhan;
  VanBanDiNoiNhan({
    required this.id,
    required this.maVB,
    required this.maNoiNhan,
    required this.noiNhan
  });
  factory VanBanDiNoiNhan.fromJson(Map<String, dynamic>? json) {
    return VanBanDiNoiNhan(
        id: json!= null ? json['id'] : -1,
        maVB: json!= null && json['maVB'] != null ? json['maVB'] : 0,
        maNoiNhan: json!= null && json['maNoiNhan'] != null ? json['maNoiNhan'] : 0,
        noiNhan: DonViNgoai.fromJson(json!= null ?json['noiNhan']: null),
    );
  }
}
