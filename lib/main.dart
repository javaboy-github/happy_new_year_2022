import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '大晦日カウンドダウン2022',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _newYear = DateTime(2022);
  // final _newYear = DateTime(2021, 12, 31, 21, 11);
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var diff = computeDiff(_now, _newYear);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              diff[0],
              style: const TextStyle(color: Colors.white, fontSize: 100, fontFamily: "ヒラギノ角ゴシック", fontWeight: FontWeight.w800)
            ),
            Text(
              diff[1],
              // style: Theme.of(context).textTheme.headline4
              style: TextStyle(
                  fontFamily: "Digital-7 Mono",
                  fontSize: diff[3],
                  fontWeight: FontWeight.bold,
                  color: diff[2]
              )
            ),
            // AnimatedContainer(
            //   height: 100,
            //   width: 100,
            //
            // )
          ],
        ),
      ),
      backgroundColor: const Color(0x2A333EFF),
    );
  }

  bool isTheNewYear = false;

  List computeDiff(DateTime now, DateTime newyear) {
    if (newyear.isAfter(now)) {
      final Duration difference = newyear.difference(now);
      final int totalSecond = difference.inSeconds;

      var hour = (totalSecond ~/ 3600).toString().padLeft(2, "0");
      var min = (totalSecond ~/ 60 % 60).toString().padLeft(2, "0");
      var sec = (totalSecond % 3600 % 60).toString().padLeft(2, "0");
      var mili = (difference.inMilliseconds % 100).toString().padLeft(2, "0");

      if (totalSecond > 60*60) {
        return ["2022年まで", "$hour:$min:$sec.$mili", Colors.green, 60.0];
      } else if (totalSecond > 60) {
        return ["2022年まで", "$min:$sec.$mili", Colors.yellow, 100.0];
      } else {
        return ["2022年まで", "$sec.$mili", Colors.red, 140.0];
      }

    } else {
      if (!isTheNewYear) {

        isTheNewYear = true;
      }
      return ["2022年です。", "HAPPY NEW YEAR", Colors.yellow, 80.0];
    }
  }
}