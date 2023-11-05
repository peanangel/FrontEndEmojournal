// import '/menu/drawer.dart';
import 'package:demo/models/index.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../toHex.dart';

class calendarPage extends StatefulWidget {
  final Profile? user;
  const calendarPage({Key? key, this.user}) : super(key: key);

  @override
  State<calendarPage> createState() => _calendarPagerState();
}

class _calendarPagerState extends State<calendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focuseDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFF1E9'),
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: HexColor('#FFF1E9'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            daysOfWeekStyle: const DaysOfWeekStyle(
              // Weekend days color (Sat,Sun)
              weekendStyle: TextStyle(color: Colors.red),
            ),
            calendarStyle: const CalendarStyle(
              // Weekend dates color (Sat & Sun Column)
              weekendTextStyle: TextStyle(color: Colors.red),
              // highlighted color for today
              todayDecoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              // highlighted color for selected day
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            locale: "en_US",
            rowHeight: 43,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            onDaySelected: _onDaySelected,
          ),
        ),
      ],
    );
  }
}
