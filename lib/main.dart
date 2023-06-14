import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tifapp/apicall.dart';
import 'package:tifapp/card.dart';
import 'package:tifapp/event.dart';
import 'package:tifapp/eventdetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override //rgb(87 105 255)
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                iconColor: MaterialStateProperty.all<Color>(Colors.black),
                iconSize: MaterialStatePropertyAll(16))),
        textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontFamily: "Inter",
              fontSize: 35,
              color: Colors.black,
            ),
            labelSmall: TextStyle(
              fontFamily: "Inter",
              fontSize: 13,
              color: Color.fromRGBO(87, 105, 255, 1),
            ),
            headlineMedium: TextStyle(
                fontFamily: "Inter",
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w400),
            titleMedium: TextStyle(
                fontFamily: "Inter",
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w400),
            titleSmall: TextStyle(
                fontFamily: "Inter",
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "Inter",
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Color.fromRGBO(87, 105, 255, 1), primary: Colors.white),
      ),
      home: EventDetails(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Event>? events = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    events = await apiCall().getEvents();
    Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 30,
              ))
        ],
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Events",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => ListCard(
          imageUrl: events![index].banner_image,
          date_time: events![index].date_time,
          title: events![index].title,
          venue_name: events![index].venue_name,
          venue_city: events![index].venue_city,
          venue_country: events![index].venue_country,
        ),
        itemCount: events!.length,

        ///events!.length,
        scrollDirection: Axis.vertical,
      )),
    );
  }
}
