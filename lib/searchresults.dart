import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tifapp/event.dart';
import 'package:http/http.dart' as http;
import 'package:tifapp/searchcard.dart';
import 'dart:convert';
import 'dart:async';
import 'card.dart';

class SearchEventBloc {
  final _searchEventController = StreamController<List<Event>>();

  Stream<List<Event>> get searchEventStream => _searchEventController.stream;

  Future<void> getSearchEvents(String searchQuery) async {
    var url = "https://sde-007.api.assignment.theinternetfolks.works";
    final response = await http
        .get(Uri.parse(url + "/v1/event?search=$searchQuery"), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Date": "Fri, 24 Mar 2023 10:58:52 GMT",
    });

    List<Event> searchResults = [];
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> events = data['content']['data'];
        searchResults =
            events.map((eventData) => Event.fromJson(eventData)).toList();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    _searchEventController.add(searchResults);
  }

  void dispose() {
    _searchEventController.close();
  }
}

class searchEvent extends StatefulWidget {
  const searchEvent({super.key});

  @override
  State<searchEvent> createState() => _searchEventState();
}

class _searchEventState extends State<searchEvent> {
  SearchEventBloc searchevent = SearchEventBloc();

  TextEditingController search = TextEditingController();
  void _getData(String s) async {
    searchevent.getSearchEvents(s);
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
            StreamBuilder<List<Event>>(
                stream: searchevent.searchEventStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          SearchCard(
                        id: data[index].id,
                        banner_image: data[index].banner_image,
                        date_time: data[index].date_time,
                        title: data[index].title,
                      ),
                      itemCount: data!.length,

                      ///events!.length,
                      scrollDirection: Axis.vertical,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                        child: Text("NO DATA TO SHOW,SEARCH SOMETHING UP!"));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
