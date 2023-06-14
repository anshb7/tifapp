import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:tifapp/eventdetails.dart';

class SearchCard extends StatelessWidget {
  SearchCard(
      {super.key,
      required this.banner_image,
      required this.date_time,
      required this.description,
      required this.organiser_icon,
      required this.organiser_name,
      required this.title,
      required this.venue_city,
      required this.venue_country,
      required this.venue_name});

  String title = "";
  String description = "";
  String banner_image = "";
  String date_time;
  String organiser_name = "";
  String organiser_icon = "";
  String venue_name = "";
  String venue_city = "";
  String venue_country = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetails(
                        banner_image: banner_image,
                        date_time: date_time,
                        description: description,
                        organiser_icon: organiser_icon,
                        organiser_name: organiser_name,
                        title: title,
                        venue_city: venue_city,
                        venue_country: venue_country,
                        venue_name: venue_name)));
          },
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 200,
                      width: 100,
                      child: Image.network(
                        banner_image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Text(
                                "${DateFormat('EE,d MMM').format(DateTime.parse(date_time))}•${DateFormat('h:mm a').format(DateTime.parse(date_time))}",
                                style: Theme.of(context).textTheme.labelSmall),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Flexible(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ]),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
