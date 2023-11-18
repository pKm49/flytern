import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/extra_package/flight_addon_extra_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/extra_package/flight_addon_set_extra_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/meal/flight_addon_get_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/meal/flight_addon_set_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/seat/flight_addon_flight_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/extra_package/flight_addon_get_extra_package.dart';
 import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/seat/flight_addon_get_seat.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/meal/flight_addon_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/flight_addon_passenger.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/flight_addon_route.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/seat/flight_addon_set_seat.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/booking_ref_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_details.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_filter_body.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_pretraveller_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_traveller_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/get_gateway_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/payment_confirmation_data.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway_url_data.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class FlightBookingHttpService {
  Future<ExploreData?> getInitialInfo() async {
    FlyternHttpResponse response =
        await getRequest(FlightBookingHttpRequestEndpointGetInitalInfo, null);

    if (response.success) {
      if (response.data != null) {
        ExploreData exploreData = mapExploreData(response.data);
        return exploreData;
      }
    }

    return null;
  }

  Future<List<FlightDestination>> getFlightDestinations(
      String searchQuery) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetDestinations,
        {"search": searchQuery});
    List<FlightDestination> flightDestinations = [];
    if (response.success) {
      if (response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          flightDestinations.add(mapFlightDestination(response.data[i]));
        }
        flightDestinations.sort((a, b) => a.sort.compareTo(b.sort));
      }
    }

    return flightDestinations;
  }

  Future<FlightSearchResult> getFlightSearchResults(
      FlightSearchData flightSearchData) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSearchFlights,
        flightSearchData.toJson());

    List<FlightSearchResponse> searchResponses = [];
    List<SortingDcs> sortingDcs = [];
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> airlineDcs = [];
    List<SortingDcs> departureTimeDcs = [];
    List<SortingDcs> arrivalTimeDcs = [];
    List<SortingDcs> stopDcs = [];

    if (response.success) {
      if (response.data != null) {
        if (response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapFlightSearchResponse(response.data["searchResponses"][i]));
          }
        }
        if (response.data["sortingDcs"] != null) {
          for (var i = 0; i < response.data["sortingDcs"].length; i++) {
            sortingDcs.add(mapSortingDcs(response.data["sortingDcs"][i]));
          }
        }
        if (response.data["priceDcs"] != null) {
          for (var i = 0; i < response.data["priceDcs"].length; i++) {
            priceDcs.add(mapRangeDcs(response.data["priceDcs"][i]));
          }
        }
        if (response.data["airlineDcs"] != null) {
          for (var i = 0; i < response.data["airlineDcs"].length; i++) {
            airlineDcs.add(mapSortingDcs(response.data["airlineDcs"][i]));
          }
        }
        if (response.data["departureTimeDcs"] != null) {
          for (var i = 0; i < response.data["departureTimeDcs"].length; i++) {
            departureTimeDcs
                .add(mapSortingDcs(response.data["departureTimeDcs"][i]));
          }
        }
        if (response.data["arrivalTimeDcs"] != null) {
          for (var i = 0; i < response.data["arrivalTimeDcs"].length; i++) {
            arrivalTimeDcs
                .add(mapSortingDcs(response.data["arrivalTimeDcs"][i]));
          }
        }
        if (response.data["stopDcs"] != null) {
          for (var i = 0; i < response.data["stopDcs"].length; i++) {
            stopDcs.add(mapSortingDcs(response.data["stopDcs"][i]));
          }
        }
      }
    }

    FlightSearchResult flightSearchResult = FlightSearchResult(
        searchResponses: searchResponses,
        priceDcs: priceDcs,
        sortingDcs: sortingDcs,
        airlineDcs: airlineDcs,
        departureTimeDcs: departureTimeDcs,
        arrivalTimeDcs: arrivalTimeDcs,
        stopDcs: stopDcs);

    return flightSearchResult;
  }

  Future<List<FlightSearchResponse>> getFlightSearchResultsFiltered(
      FlightFilterBody flightFilterBody) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointFilterFlights,
        flightFilterBody.toJson());

    List<FlightSearchResponse> searchResponses = [];
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapFlightSearchResponse(response.data["searchResponses"][i]));
          }
        }
      }
    }

    return searchResponses;
  }

  Future<FlightSearchResult> getMoreOptions(int index, int objectId) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetMoreOptionFlights,
        {"objectID": objectId, "index": index});

    List<FlightSearchResponse> searchResponses = [];

    if (response.success) {
      if (response.data != null) {
        if (response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapFlightSearchResponse(response.data["searchResponses"][i]));
          }
        }
      }
    }

    FlightSearchResult flightSearchResult = FlightSearchResult(
        searchResponses: searchResponses,
        priceDcs: [],
        sortingDcs: [],
        airlineDcs: [],
        departureTimeDcs: [],
        arrivalTimeDcs: [],
        stopDcs: []);

    return flightSearchResult;
  }

  Future<FlightDetails> getFlightDetails(int index, int objectId) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetDetailFlights,
        {"objectID": objectId, "index": index});

    FlightDetails flightDetails;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        flightDetails = mapFlightDetails(response.data);
        return flightDetails;
      }
    }

    return mapFlightDetails({});
  }

  Future<FlightPretravellerData> getPreTravellerData(int detailId) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetPreTravellerData,
        {"detail_id": detailId});

    FlightPretravellerData flightPretravellerData;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        flightPretravellerData = mapFlightPretravellerData(response.data);
        return flightPretravellerData;
      }
    }

    return mapFlightPretravellerData({});
  }

  Future<BookingRefData> setTravellerData(
      FlightTravellerData flightTravellerData) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetSaveTravellerData,
        flightTravellerData.toJson());

    String bookingRef = "";
    bool isSeatSelection = false;
    bool isMealSelection = false;
    bool isExtraBaggageSelection = false;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        bookingRef = response.data["bookingRef"] ?? "";
        if (response.data["isAddOn"] == true) {
          isSeatSelection = response.data["_AddonService"]["isSeatSelection"];
          isMealSelection = response.data["_AddonService"]["isMealSelection"];
          isExtraBaggageSelection =
              response.data["_AddonService"]["isExtraBaggageSelection"];
        }
      }
    }

    return BookingRefData(
      bookingRef: bookingRef,
      isSeatSelection: isSeatSelection,
      isMealSelection: isMealSelection,
      isExtraBaggageSelection: isExtraBaggageSelection,
    );
  }

  Future<bool> checkSmartPayment(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSmartPayment,
        {"bookingRef": bookingRef});

    print("getPaymentGateways");
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] != null) {
          return response.data["isSuccess"];
        }
      }
    }

    return false;
  }

  Future<GetGatewayData> getPaymentGateways(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetGateways,
        {"bookingRef": bookingRef});

    List<PaymentGateway> paymentGateways = [];
    FlightDetails flightDetails = mapFlightDetails({});

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isGateway"]) {
          response.data["_gatewaylist"].forEach((element) {
            paymentGateways.add(mapPaymentGateway(element));
          });
        }
        print("flightDetails");
        print(response.data["_flightservice"]);
        print(response.data["_flightservice"]["_flightDetail"]);
        if (response.data["_flightservice"] != null) {
          if (response.data["_flightservice"]["_flightDetail"] != null) {
            flightDetails = mapFlightDetails(
                response.data["_flightservice"]["_flightDetail"]);
            print("flightDetails");
            print(flightDetails.objectId);
          }
        }
      }
    }

    return GetGatewayData(
        paymentGateways: paymentGateways, flightDetails: flightDetails);
  }

  Future<FlightAddonGetSeat> getSeats(String bookingRef) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetSeats, {"bookingRef": bookingRef});

    List<FlightAddonRoute> routes = [];
    List<FlightAddonPassenger> passengers = [];
    List<FlightAddonFlightClass> flightClass = [];

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["routes"]!= null ) {
          response.data["routes"].forEach((element) {
            routes.add(mapFlightAddonRoute(element));
          });
        }

        if (response.data["passengers"]!= null) {
          response.data["passengers"].forEach((element) {
            passengers.add(mapFlightAddonPassenger(element));
          });
        }
        if (response.data["flightClass"]!= null) {
          response.data["flightClass"].forEach((element) {
            flightClass.add(mapFlightAddonFlightClass(element));
          });
        }
      }
    }

    return FlightAddonGetSeat(
        routes: routes, passengers: passengers, flightClass: flightClass);
  }

  Future<bool> setSeats(FlightAddonSetSeat flightAddonSetSeatData) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSaveSeat, flightAddonSetSeatData.toJson());


    if (response.success && response.statusCode == 200) {
       return true;
    }

    return false;
  }

  Future<bool> setMeals(FlightAddonSetMeal flightAddonSetMealData) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSaveMeal, flightAddonSetMealData.toJson());


    if (response.success && response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> setExtraBuggage(FlightAddonSetExtraPackage flightAddonSetExtraPackage) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSaveExtraLuaggage, flightAddonSetExtraPackage.toJson());


    if (response.success && response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<FlightAddonGetMeal> getMeals(String bookingRef) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetMeals, {"bookingRef": bookingRef});

    List<FlightAddonRoute> routes = [];
    List<FlightAddonPassenger> passengers = [];
    List<FlightAddonMeal> meals = [];

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["routes"]!= null) {
          response.data["routes"].forEach((element) {
            routes.add(mapFlightAddonRoute(element));
          });
        }

        if (response.data["passengers"]!= null) {
          response.data["passengers"].forEach((element) {
            passengers.add(mapFlightAddonPassenger(element));
          });
        }
        if (response.data["meals"]!= null) {
          response.data["meals"].forEach((element) {
            meals.add(mapFlightAddonMeal(element));
          });
        }
      }
    }

    return FlightAddonGetMeal(
        routes: routes, passengers: passengers, meals: meals);
  }

  Future<FlightAddonGetExtraPackage> getExtraPackage(String bookingRef) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetExtraLuaggage, {"bookingRef": bookingRef});

    List<FlightAddonRoute> routes = [];
    List<FlightAddonPassenger> passengers = [];
    List<FlightAddonExtraPackage> extraPackages = [];

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["routes"]!= null) {
          response.data["routes"].forEach((element) {
            routes.add(mapFlightAddonRoute(element));
          });
        }

        if (response.data["passengers"]!= null) {
          response.data["passengers"].forEach((element) {
            passengers.add(mapFlightAddonPassenger(element));
          });
        }
        if (response.data["extraPackages"]!= null) {
          response.data["extraPackages"].forEach((element) {
            extraPackages.add(mapFlightAddonExtraPackage(element));
          });
        }
      }
    }

    return FlightAddonGetExtraPackage(
        routes: routes, passengers: passengers, extraPackages: extraPackages);
  }

  Future<bool> checkGatewayStatus(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointCheckGatewayStatus,
        {"bookingRef": bookingRef});

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] != null) {
          return response.data["isSuccess"];
        }
      }
    }

    return false;
  }

  Future<PaymentConfirmationData> getConfirmationData(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointConfirmation,
        {"bookingRef": bookingRef});

    print("getConfirmationData");
    print(response.data["isIssued"]);
    print(response.data["pdfLink"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentConfirmationData paymentConfirmationData =
            mapPaymentpdfLinkData(response.data);
        return paymentConfirmationData;
      }
    }

    return mapPaymentpdfLinkData({});
  }

  Future<PaymentGatewayUrlData> setPaymentGateway(
      String processID, String paymentCode, String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSetGateway, {
      "processID": processID,
      "paymentCode": paymentCode,
      "bookingRef": bookingRef
    });

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentGatewayUrlData paymentGatewayUrlData =
            mapPaymentGatewayUrlData(response.data);
        return paymentGatewayUrlData;
      }
    }

    return mapPaymentGatewayUrlData({});
  }

  Future<List<RecommendedPackage>> getRecommended(int pageId) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetViewAllRecommeded,
        {"pageid": pageId.toString()});
    List<RecommendedPackage> recommendedPackages = [];
    if (response.success) {
      if (response.data != null) {
        if (response.data["records"] != null) {
          response.data["records"].forEach((element) {
            recommendedPackages.add(mapRecommendedPackage(element));
          });
          return recommendedPackages;
        }
      }
    }

    return [];
  }

  Future<List<TravelStory>> getTravelStories(int pageId) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetViewAllRecommeded,
        {"pageid": pageId.toString()});
    List<TravelStory> travelStories = [];
    if (response.success) {
      if (response.data != null) {
        if (response.data["records"] != null) {
          response.data["records"].forEach((element) {
            travelStories.add(mapTravelStory(element));
          });
          return travelStories;
        }
      }
    }

    return [];
  }

  Future<List<PopularDestination>> getPopularDestinations(int pageId) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetViewAllRecommeded,
        {"pageid": pageId.toString()});
    List<PopularDestination> popularDestination = [];
    if (response.success) {
      if (response.data != null) {
        if (response.data["records"] != null) {
          response.data["records"].forEach((element) {
            popularDestination.add(mapPopularDestination(element));
          });
          return popularDestination;
        }
      }
    }

    return [];
  }
}
