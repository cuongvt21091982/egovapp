import 'package:egovapp/model/calendar/calendardepart.dart';


class CalendarDepartWeek
{
  final int week;
  final int day;
  final String dateWeek;
  final List<CalendarDepart> calendars;
  CalendarDepartWeek({
    required this.week,
    required this.day,
    required this.dateWeek,
    required this.calendars
  });
  factory CalendarDepartWeek.fromJson(Map<String, dynamic>? json) {
    return CalendarDepartWeek(
        week: json!= null && json['week'] != null? json['week']: 0,
        day: json!= null &&  json['day'] != null? json['day']: 0,
        dateWeek:json!= null &&  json['dateWeek'] != null? json['dateWeek']: '',
        calendars: json!= null &&  json['calendars']!=null? (json['calendars'] as List)
            .map((data) => CalendarDepart.fromJson(data))
            .toList(): []
    );
  }
}