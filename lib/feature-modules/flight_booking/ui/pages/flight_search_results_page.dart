import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightSearchResultPage extends StatefulWidget {
  const FlightSearchResultPage({super.key});

  @override
  State<FlightSearchResultPage> createState() => _FlightSearchResultPageState();
}

class _FlightSearchResultPageState extends State<FlightSearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search_results".tr),
        actions: [Icon(CupertinoIcons.create)],
      ),
    );
  }
}
