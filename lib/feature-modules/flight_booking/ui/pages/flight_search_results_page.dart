import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
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
        actions: [
          Icon(Ionicons.create_outline),
          addHorizontalSpace(flyternSpaceMedium),
        ],
      ),
    );
  }
}
