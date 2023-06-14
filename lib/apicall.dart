import 'package:http/http.dart' as http;
import 'event.dart';
import 'dart:io';
import 'dart:convert';

class apiCall {
  Future<List<Event>?> getEvents() async {
    try {
      var url = "https://sde-007.api.assignment.theinternetfolks.works";
      final response = await http.get(Uri.parse(url + "/v1/event"), headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Date": "Fri, 24 Mar 2023 10:58:42 GMT",
        "Transfer-Encoding": "chunked"
      });

      List<Event> ans = [];

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> events = data['content']['data'];
        for (var i in events) {
          Event eventt = Event.fromJson(i);
          ans.add(eventt);
        }
        return ans;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
