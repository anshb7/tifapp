import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:animated_button/animated_button.dart';
import 'package:tifapp/eventAPI.dart';
import 'package:connectivity/connectivity.dart';

class EventDetails extends StatefulWidget {
  EventDetails({super.key, required this.id, required this.banner_image});

  int id;
  String banner_image;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final _event = EventBloc();
  bool _showProgressIndicator = false;
  @override
  void initState() {
    print(widget.id.toString());
    _event.getEventDetails(widget.id.toString());

    super.initState();
    setState(() {});
  }

  void dispose() {
    _event.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedButton(
          shadowDegree: ShadowDegree.light,
          onPressed: () {},
          color: Color.fromRGBO(87, 105, 255, 1),
          width: 271,
          child: Text(
            'BOOK NOW!',
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.banner_image))),
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
      body: StreamBuilder(
          stream: _event.eventStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      data!.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListTile(
                      subtitle: Text(
                        "Organizer",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      title: Text(data.organiser_name,
                          style: Theme.of(context).textTheme.headlineMedium),
                      visualDensity: VisualDensity(vertical: 4),
                      leading: Container(
                        height: 54,
                        width: 51,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(data.organiser_icon))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListTile(
                      title: Text(
                          DateFormat('MMMM d,yyyy')
                              .format(DateTime.parse(data.date_time)),
                          style: Theme.of(context).textTheme.headlineSmall),
                      subtitle: Text(
                        DateFormat('EEEE,hh:mm aaa')
                            .format(DateTime.parse(data.date_time)),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
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
                  ListTile(
                    title: Text(data.venue_name,
                        style: Theme.of(context).textTheme.headlineSmall),
                    subtitle: Text(
                      "${data.venue_city}, ${data.venue_country}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text("About Event",
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(data.description,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ));
            }
          }),
    );
  }
}
