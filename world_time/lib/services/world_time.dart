import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location, time, flag, url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      String operation = data['utc_offset'].substring(0, 1);

      //create a DateTime object
      DateTime now = DateTime.parse(datetime);

      if(operation == '-') {now = now.subtract(Duration(hours: int.parse(offset)));}
      else {now = now.subtract(Duration(hours: int.parse(offset)));}

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Error caught: $e');
      time = 'Could not get time data.';
    }
  }
}
