import 'dart:async';

import 'package:http/http.dart' as http;
import 'event.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class EventsBloc {
  final _eventListController = StreamController<List<Event>>();

  Stream<List<Event>> get eventListStream => _eventListController.stream;

  Future<void> getEvents() async {
    try {
      var url = "https://sde-007.api.assignment.theinternetfolks.works";
      final response = await http.get(Uri.parse(url + "/v1/event"), headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Date": "Fri, 24 Mar 2023 10:58:42 GMT",
        "Transfer-Encoding": "chunked"
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> events = data['content']['data'];
        List<Event> eventList =
            events.map((eventData) => Event.fromJson(eventData)).toList();
        _eventListController.add(eventList);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void dispose() {
    _eventListController.close();
  }
}
