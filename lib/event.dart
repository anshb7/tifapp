import 'package:flutter/material.dart';

class Event with ChangeNotifier {
  int id = 0;
  String title = "";
  String description = "";
  String banner_image = "";
  String date_time = "";
  String organiser_name = "";
  String organiser_icon = "";
  String venue_name = "";
  String venue_city = "";
  String venue_country = "";

  Event(
      {required this.id,
      required this.title,
      required this.banner_image,
      required this.date_time,
      required this.description,
      required this.organiser_icon,
      required this.organiser_name,
      required this.venue_city,
      required this.venue_country,
      required this.venue_name});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        title: json['title'],
        banner_image: json['banner_image'],
        date_time: json['date_time'],
        description: json['description'],
        organiser_icon: json['organiser_icon'],
        organiser_name: json['organiser_name'],
        venue_city: json['venue_city'],
        venue_country: json['venue_country'],
        venue_name: json['venue_name']);
  }
}
