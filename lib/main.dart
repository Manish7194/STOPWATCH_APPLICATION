import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _elapsedTime = '00:00.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Stopwatch App'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _elapsedTime,
                style: const TextStyle(fontSize: 36),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _startStopwatch,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.play_arrow),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _stopStopwatch,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.stop),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _resetStopwatch,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startStopwatch() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
    _stopwatch.start();
  }

  void _stopStopwatch() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _stopwatch.stop();
  }

  void _resetStopwatch() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '00:00.0';
    });
  }

  String _formatTime(int milliseconds) {
    int tenths = (milliseconds / 100).truncate() % 10;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (seconds / 60).truncate();

    return '${_twoDigits(minutes)}:${_twoDigits(seconds)}.$tenths';
  }

  String _twoDigits(int n) {
    return n >= 10 ? '$n' : '0$n';
  }
}
