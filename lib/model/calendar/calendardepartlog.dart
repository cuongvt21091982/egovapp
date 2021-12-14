import 'package:egovapp/model/calendar/calendardepart.dart';
import 'package:egovapp/model/log/logaction.dart';
class CalendarDepartLog
{
  final CalendarDepart calendarDepart;
  final LogAction logAction;

  CalendarDepartLog({
    required this.calendarDepart,
    required this.logAction
  });
  factory CalendarDepartLog.fromJson(Map<String, dynamic>? json) {
    return CalendarDepartLog(
      calendarDepart: CalendarDepart.fromJson(json!= null ?json['calendarDepart']: null),
      logAction: LogAction.fromJson(json!= null ?json['logAction']: null),

    );
  }
}