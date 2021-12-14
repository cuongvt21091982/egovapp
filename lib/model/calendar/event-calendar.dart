import 'package:flutter/material.dart';
class EventCalendar {
  EventCalendar(this.id,this.eventName, this.from, this.to, this.background, this.isAllDay);
  int id;
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}