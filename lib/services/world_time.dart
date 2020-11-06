import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    // Make the Request
    try {
      final Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      final Map data = jsonDecode(response.body);

      // Get properties from data
      final String dateTime = data['datetime'];
      final String offset = data['utc_offset'].substring(1, 3);

      final DateTime now = DateTime.parse(dateTime).add(
        Duration(
          hours: int.parse(offset),
        ),
      );

      // Set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
