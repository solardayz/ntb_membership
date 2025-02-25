import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Membership App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MembershipScreen(),
    );
  }
}

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  DateTime? _selectedDate;

  void _onDateChanged(DateTime? newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('멤버십'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://news.kbs.co.kr/data/news/2010/11/22/2197852_OF9.jpg'), // 여기에 실제 이미지 URL을 넣으세요.
                ),
                const SizedBox(width: 20),
                const Text(
                  '신종훈',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: _onDateChanged,
          ),
          if (_selectedDate != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '선택된 날짜: ${_selectedDate!.year}년 ${_selectedDate!.month}월 ${_selectedDate!.day}일',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          const Expanded(
            child: AttendanceHistoryGraph(),
          ),
        ],
      ),
    );
  }
}

class AttendanceHistoryGraph extends StatefulWidget {
  const AttendanceHistoryGraph({super.key});

  @override
  State<AttendanceHistoryGraph> createState() => _AttendanceHistoryGraphState();
}

class _AttendanceHistoryGraphState extends State<AttendanceHistoryGraph> {
  late Map<int, List<bool>> _attendanceData;

  @override
  void initState() {
    super.initState();
    _attendanceData = _generateRandomAttendanceData();
  }

  Map<int, List<bool>> _generateRandomAttendanceData() {
    final random = Random();
    final attendanceData = <int, List<bool>>{};
    for (int month = 1; month <= 12; month++) {
      final daysInMonth = DateTime(DateTime.now().year, month + 1, 0).day;
      attendanceData[month] =
          List.generate(daysInMonth, (index) => random.nextBool());
    }
    return attendanceData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '출석체크 히스토리',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(12, (monthIndex) {
                  final month = monthIndex + 1;
                  final monthData = _attendanceData[month]!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$month월'),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(monthData.length, (dayIndex) {
                            final isAttended = monthData[dayIndex];
                            final barHeight = isAttended ? 100.0 : 50.0;
                            final barColor =
                            isAttended ? Colors.blue : Colors.grey;
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 5,
                                    height: barHeight,
                                    color: barColor,
                                  ),
                                  const SizedBox(height: 5),
                                  if (dayIndex % 5 == 0)
                                    Text('${dayIndex + 1}'),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}