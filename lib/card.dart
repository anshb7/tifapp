import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class ListCard extends StatelessWidget {
  ListCard(
      {super.key,
      required this.imageUrl,
      required this.date_time,
      required this.title,
      required this.venue_name,
      required this.venue_city,
      required this.venue_country});

  String imageUrl;
  String date_time;
  String title;
  String venue_name;
  String venue_city;
  String venue_country;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              height: MediaQuery.of(context).size.height * 0.16,
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
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              "${DateFormat('EE,d MMM').format(DateTime.parse(date_time))}•${DateFormat('h:mm a').format(DateTime.parse(date_time))}",
                              style: Theme.of(context).textTheme.labelSmall),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            """${venue_name}, ${venue_city}, ${venue_country}""",
                            style: Theme.of(context).textTheme.titleMedium,
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
