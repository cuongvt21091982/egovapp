class LoaiKeHoach
{
  final int id;
  final String tenKeHoach;
  final int stt;
  LoaiKeHoach({
    required this.id,
    required this.tenKeHoach,
    required this.stt

  });
  factory LoaiKeHoach.fromJson(Map<String, dynamic>? json) {
    return LoaiKeHoach(
      id: json != null ? json['id'] : -1,
      tenKeHoach: json != null && json['tenKeHoach']!=null? json['tenKeHoach']: '',
        stt: json != null && json['stt']!=null? json['stt']: 0
    );
  }
}
