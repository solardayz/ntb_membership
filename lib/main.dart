import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Membership'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // 검은색 계열 배경색
      appBar: AppBar(
        backgroundColor: Colors.grey[800], // 어두운 회색 앱바 배경색
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Welcome to NTB',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300]), // 밝은 회색 텍스트
            ),
            Text(
              '금주의 출석 횟수: 10',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.grey[800], // 어두운 회색 플로팅 액션 버튼 배경색
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ), // 흰색 아이콘
      ),
    );
  }
}