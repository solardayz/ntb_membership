import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위해

void main() {
  runApp(MembershipApp());
}

class MembershipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Membership',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MembershipScreen(),
    );
  }
}

class MembershipScreen extends StatefulWidget {
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  // 각 통계에 대한 예시 퍼센트 값
  final double overallAttendance = 0.75;
  final double weeklyAttendance = 0.60;
  final double monthlyAttendance = 0.80;

  // 예시 월별 출석률 데이터 (1월부터 12월까지)
  final List<double> monthlyAttendanceData = [0.8, 0.75, 0.9, 0.6, 0.85, 0.7, 0.8, 0.95, 0.65, 0.9, 0.8, 0.77];
  final List<String> monthLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  // 선택된 날짜 (초기값은 오늘)
  DateTime _selectedDate = DateTime.now();

  // 날짜 선택 다이얼로그 호출 함수
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 날짜를 "yyyy-MM-dd" 형식으로 변환하여 리턴하는 함수
  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('통합멤버십'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            // 프로필 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40, // 프로필 크기 축소
                  backgroundImage: NetworkImage(
                    'https://pimg.mk.co.kr/meet/neds/2014/10/image_readtop_2014_1274942_14123176891560616.jpg', // 실제 사진 URL로 교체
                  ),
                ),
                SizedBox(height: 8,width: 10,),
                Text(
                  '신종훈',
                  style: TextStyle(
                    fontSize: 25, // 글씨 크기 축소
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // 날짜 선택 영역 (원형 통계 상단)
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            // 세 개의 작은 원형 통계를 가로로 나열
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 전체 출석률
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularPercentIndicator(
                      radius: 40.0, // 작게
                      lineWidth: 5.0,
                      percent: overallAttendance,
                      center: Text(
                        "${(overallAttendance * 100).toInt()}%",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey[300]!,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 1000,
                    ),
                    SizedBox(height: 4),
                    Text("전체", style: TextStyle(fontSize: 12)),
                  ],
                ),
                // 주간 출석률
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 5.0,
                      percent: weeklyAttendance,
                      center: Text(
                        "${(weeklyAttendance * 100).toInt()}%",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Colors.blue,
                      backgroundColor: Colors.grey[300]!,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 1000,
                    ),
                    SizedBox(height: 4),
                    Text("주간", style: TextStyle(fontSize: 12)),
                  ],
                ),
                // 월별 출석률
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 5.0,
                      percent: monthlyAttendance,
                      center: Text(
                        "${(monthlyAttendance * 100).toInt()}%",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Colors.orange,
                      backgroundColor: Colors.grey[300]!,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 1000,
                    ),
                    SizedBox(height: 4),
                    Text("월별", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // 월별 막대 그래프 영역
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 200, // 고정 높이
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(monthlyAttendanceData.length, (index) {
                    double attendance = monthlyAttendanceData[index];
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // 막대
                          Container(
                            height: attendance * 150, // 최대 150 픽셀 (100% 출석)
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 4),
                          // 월 라벨
                          Text(
                            monthLabels[index],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "월별 출석률",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: ElevatedButton(onPressed: (){}, child: Text('출석체크')),
            ),
            Spacer(),
            // 푸터 영역
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Colors.blueGrey[50],
              child: Text(
                'NTB © 2025',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
