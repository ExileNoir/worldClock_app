import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    final WorldTime germanTime = WorldTime(
        location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');

    await germanTime.getTime();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': germanTime.location,
      'flag': germanTime.flag,
      'time': germanTime.time,
      'isDayTime': germanTime.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
