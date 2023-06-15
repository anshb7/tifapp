import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tifapp/eventdetails.dart';
import 'event.dart';

import 'dart:convert';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventBloc {
  final _eventController = StreamController<Event>();

  Stream<Event> get eventStream => _eventController.stream;

  Future<void> getEventDetails(String s) async {
    try {
      var url = "https://sde-007.api.assignment.theinternetfolks.works";
      final response =
          await http.get(Uri.parse(url + "/v1/event/${s}"), headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Date": "Fri, 24 Mar 2023 10:58:29 GMT",
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var event = data['content']['data'];
        Event eventt = Event.fromJson(event);
        _eventController.add(eventt);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void dispose() {
    _eventController.close();
  }
}
