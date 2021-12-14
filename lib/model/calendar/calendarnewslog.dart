import 'package:egovapp/model/calendar/calendarnews.dart';
import 'package:egovapp/model/log/logaction.dart';
class CalendarNewsLog
{
  final CalendarNews calendarNews;
  final LogAction logAction;

  CalendarNewsLog({
    required this.calendarNews,
    required this.logAction
  });
  factory CalendarNewsLog.fromJson(Map<String, dynamic>? json) {
    return CalendarNewsLog(
      calendarNews: CalendarNews.fromJson(json!= null ?json['calendarNews']: null),
      logAction: LogAction.fromJson(json!= null ?json['logAction']: null),

    );
  }
}