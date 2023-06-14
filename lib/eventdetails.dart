import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: AppBar(
          flexibleSpace: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://filminformation.com/wp-content/uploads/2023/06/spider-maxresdefault.jpg"))),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_add,
                  color: Colors.white,
                  size: 30,
                )),
          ],
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Event Details",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "[Event Name]",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListTile(
                  subtitle: Text(
                    "Organizer",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  title: Text("[Organizer Name]",
                      style: Theme.of(context).textTheme.headlineMedium),
                  visualDensity: VisualDensity(vertical: 4),
                  leading: Container(
                    height: 54,
                    width: 51,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://filminformation.com/wp-content/uploads/2023/06/spider-maxresdefault.jpg"))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListTile(
                  leading: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage("assets/images/Date.png"))),
                  ),
                  visualDensity: VisualDensity(vertical: 4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListTile(
                  visualDensity: VisualDensity(vertical: 4),
                  leading: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage("assets/images/Location.png"))),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
