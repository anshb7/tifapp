import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tifapp/event.dart';
import 'package:http/http.dart' as http;
import 'package:tifapp/searchcard.dart';
import 'dart:convert';
import 'card.dart';

class searchResult {
  Future<List<Event>> getSearchEvents(String s) async {
    var url = "https://sde-007.api.assignment.theinternetfolks.works";
    final response =
        await http.get(Uri.parse(url + "/v1/event?search=${s}"), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Date": "Fri, 24 Mar 2023 10:58:52 GMT",
    });

    List<Event> ans = [];
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> events = data['content']['data'];
        for (var i in events) {
          Event eventt = Event.fromJson(i);
          ans.add(eventt);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return ans;
  }
}

class searchEvent extends StatefulWidget {
  const searchEvent({super.key});

  @override
  State<searchEvent> createState() => _searchEventState();
}

class _searchEventState extends State<searchEvent> {
  ScrollController _controller = new ScrollController();
  late List<Event> events = [];
  TextEditingController search = TextEditingController();
  void _getData(String s) async {
    events = await searchResult().getSearchEvents(s);
    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Search",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormField(
                autovalidateMode: AutovalidateMode.always,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            onChanged: (value) async {
                              setState(() {});
                              _getData(value);
                            },
                            controller: search,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(87, 105, 255, 1))),
                                hintText: "Type Event To Search",
                                icon: Icon(Icons.search),
                                iconColor: Color.fromRGBO(87, 105, 255, 1)),
                            cursorColor: Color.fromRGBO(7, 7, 9, 1),
                          )),
                    )),
            events.isEmpty
                ? Center(child: Text("NO DATA TO SHOW!"))
                : OrientationBuilder(
                    builder: (context, orientation) => ListView.builder(
                      controller: _controller,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          SearchCard(
                        organiser_icon: events[index].organiser_icon,
                        organiser_name: events[index].organiser_name,
                        description: events[index].description,
                        banner_image: events[index].banner_image,
                        date_time: events[index].date_time,
                        title: events[index].title,
                        venue_name: events[index].venue_name,
                        venue_city: events[index].venue_city,
                        venue_country: events[index].venue_country,
                      ),
                      itemCount: events.length,

                      ///events!.length,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
