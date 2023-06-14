import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tifapp/eventdetails.dart';
import 'event.dart';

import 'dart:convert';

class eventAPI {
  Future<Event?> getEventDetails(String s) async {
    try {
      var url = "https://sde-007.api.assignment.theinternetfolks.works";
      final response =
          await http.get(Uri.parse(url + "/v1/event/${s}"), headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Date": "Fri, 24 Mar 2023 10:58:29 GMT",
      });

      Event ans = Event(
          id: 0,
          title: "",
          banner_image: "",
          date_time: "",
          description: "",
          organiser_icon: "",
          organiser_name: "",
          venue_city: "",
          venue_country: "",
          venue_name: "");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var event = data['content']['data'];
        Event eventt = Event.fromJson(event);
        ans = Event(
            id: eventt.id,
            title: eventt.title,
            banner_image: eventt.banner_image,
            date_time: eventt.date_time,
            description: eventt.description,
            organiser_icon: eventt.organiser_icon,
            organiser_name: eventt.organiser_name,
            venue_city: eventt.venue_city,
            venue_country: eventt.venue_country,
            venue_name: eventt.venue_name);
        return ans;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
