import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class DestinationSearchDelegate extends SearchDelegate {

  final flightBookingController =  Get.put(FlightBookingController());

  List<String> searchTerms = [
    "Restaurants",
        "Hotels",
        "Cafes",
        "Shopping malls",
        "Parks",
        "Hospitals",
        "Banks",
        "Movie theaters",
        "Gas stations",
        "Supermarkets",
        "Schools",
        "Gyms",
        "Pharmacies",
        "Museums",
        "Libraries",
        "Car repair shops",
        "Beauty salons",
        "Bars",
        "Tourist attractions",
        "Airports"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {

    List<String> matchQuery = [];

    for(var item in searchTerms){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    
    return ListView.builder(
        itemCount:matchQuery.length,
        itemBuilder:(context,index){
          var result = matchQuery[index];
          return ListTile(

            onTap: (){
              Navigator.pop(context);
            },
            title: Text(result),
          );
        }
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    List<String> matchQuery = [];

    for(var item in searchTerms){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }

    return Container(
      height: screenheight,
      child: Column(
        children: [
          Padding(

            padding: const EdgeInsets.symmetric(vertical: flyternSpaceMedium, horizontal: flyternSpaceLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("recent_searches".tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold)),
              Text("clear_history".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey40)),

            ],),
          ),
          Expanded(
            child: ListView.builder(
                itemCount:matchQuery.length,
                itemBuilder:(context,index){
                  var result = matchQuery[index];
                  return ListTile(
                    leading: Icon(Ionicons.search_outline,color: flyternSecondaryColor),
                    trailing: Icon(Ionicons.close,color: flyternGrey40),
                    onTap: (){
                      Navigator.pop(context);
                    },
                    title: Text(result),
                  );
                }
            ),
          ),
        ],
      ),
    );

  }

}
