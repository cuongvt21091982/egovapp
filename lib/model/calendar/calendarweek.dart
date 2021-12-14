import 'package:egovapp/model/calendar/calendar.dart';
class CalendarWeek
{
  final int week;
  final int day;
  final String dateWeek;
  final List<Calendar> calendars;
  CalendarWeek({
    required this.week,
    required this.day,
    required this.dateWeek,
    required this.calendars
  });
  factory CalendarWeek.fromJson(Map<String, dynamic>? json) {
    return CalendarWeek(
        week: json!= null && json['week'] != null? json['week']: 0,
        day: json!= null &&  json['day'] != null? json['day']: 0,
        dateWeek:json!= null &&  json['dateWeek'] != null? json['dateWeek']: '',
        calendars: json!= null &&  json['calendars']!=null? (json['calendars'] as List)
            .map((data) => Calendar.fromJson(data))
            .toList(): []
    );
  }
}