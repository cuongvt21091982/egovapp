import 'package:egovapp/model/calendar/calendarnews.dart';

class CalendarNewsWeek
{
  final int week;
  final int day;
  final String dateWeek;
  final List<CalendarNews> calendars;
  CalendarNewsWeek({
    required this.week,
    required this.day,
    required this.dateWeek,
    required this.calendars
  });
  factory CalendarNewsWeek.fromJson(Map<String, dynamic>? json) {
    return CalendarNewsWeek(
        week: json!= null && json['week'] != null? json['week']: 0,
        day: json!= null &&  json['day'] != null? json['day']: 0,
        dateWeek:json!= null &&  json['dateWeek'] != null? json['dateWeek']: '',
        calendars: json!= null &&  json['calendars']!=null? (json['calendars'] as List)
            .map((data) => CalendarNews.fromJson(data))
            .toList(): []
    );
  }
}