import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String flag;
  String api;
  bool isDay = true;

  WorldTime(this.location, this.flag, this.api);

  Future<String> getTime() async {
    try {
      Response response =
          await get(Uri.https("worldtimeapi.org", "api/timezone/$api"));
      Map jsonResponse = jsonDecode(response.body);

      String dateTime = jsonResponse["datetime"];
      int offsetHours =
          int.parse(jsonResponse["utc_offset"].toString().substring(1, 3));
      int offsetMinutes =
          int.parse(jsonResponse["utc_offset"].toString().substring(4, 6));

      DateTime currentTime = DateTime.parse(dateTime);
      currentTime =
          currentTime.add(Duration(hours: offsetHours, minutes: offsetMinutes));

      isDay = currentTime.hour > 6 && currentTime.hour < 18;

      return DateFormat.jm().format(currentTime);
    } catch (e) {
      print(e);
      return "An error occurred!";
    }
  }
}
