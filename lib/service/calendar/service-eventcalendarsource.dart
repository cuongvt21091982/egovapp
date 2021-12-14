import 'package:egovapp/model/calendar/event-calendar.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalendarDataSource extends CalendarDataSource {
  EventCalendarDataSource(List<EventCalendar> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventCalendar(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventCalendar(index).to;
  }

  @override
  String getSubject(int index) {
    return _getEventCalendar(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getEventCalendar(index).background;
  }
  EventCalendar _getEventCalendar(int index) {
    final dynamic eventCalendar = appointments![index];
    late final EventCalendar eventCalendarData;
    if (eventCalendar is EventCalendar) {
      eventCalendarData = eventCalendar;
    }
    return eventCalendarData;
  }
}