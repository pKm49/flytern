import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/constants/http_request_endpoint.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/set_extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/get_meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/set_meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/flight_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/get_extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/get_seat.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/passenger.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/route.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/set_seat.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/booking_ref_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/explore_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/filter_body.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/pretraveller_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_response.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_result.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/popular_destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/recommended_package.flight_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/models/travel_story.flight_booking.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/models/support_info.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';
import 'package:get/get.dart';

class FlightBookingHttpService {
  Future<ExploreData> getInitialInfo() async {
    try {
      FlyternHttpResponse response =
          await getRequest(FlightBookingHttpRequestEndpointGetInitalInfo, null);
      print("getInitialInfo");
      print(response.data);
      print(response.success);

      if (response.success) {
        if (response.data != null) {
          ExploreData exploreData = mapExploreData(response.data);
          return exploreData;
        }
      }

      return mapExploreData({});
    } catch (e) {
      return mapExploreData({});
    }
  }

  Future<List<FlightDestination>> getFlightDestinations(
      String searchQuery) async {
    List<FlightDestination> flightDestinations = [];
    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetDestinations,
          {"search": searchQuery});

      if (response.success) {
        if (response.data != null) {
          for (var i = 0; i < response.data.length; i++) {
            flightDestinations.add(mapFlightDestination(response.data[i]));
          }
          flightDestinations.sort((a, b) => a.sort.compareTo(b.sort));
        }
      }

      return flightDestinations;
    } catch (e) {
      return flightDestinations;
    }
  }

  Future<FlightSearchResult> getFlightSearchResults(
      FlightSearchData flightSearchData) async {
    List<FlightSearchResponse> searchResponses = [];
    List<SortingDcs> sortingDcs = [];
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> airlineDcs = [];
    List<SortingDcs> departureTimeDcs = [];
    List<SortingDcs> arrivalTimeDcs = [];
    List<SortingDcs> stopDcs = [];
    int totalFlights = 0;
    int pageSize = 0;
    String alertMsg = "";

    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointSearchFlights,
          flightSearchData.toJson());

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

          if (response.data["pageSize"] != null) {
            pageSize = int.parse(response.data["pageSize"].toString());
          }
          if (response.data["alertMsg"] != null) {
            alertMsg = response.data["alertMsg"];
          }
          if (response.data["totalFlights"] != null) {
            totalFlights = response.data["totalFlights"];
          }

          if (response.data["stopDcs"] != null) {
            for (var i = 0; i < response.data["stopDcs"].length; i++) {
              stopDcs.add(mapSortingDcs(response.data["stopDcs"][i]));
            }
          }
        }
      }

      FlightSearchResult flightSearchResult = FlightSearchResult(
          totalFlights: totalFlights,
          pageSize: pageSize,
          alertMsg: alertMsg,
          searchResponses: searchResponses,
          priceDcs: priceDcs,
          sortingDcs: sortingDcs,
          airlineDcs: airlineDcs,
          departureTimeDcs: departureTimeDcs,
          arrivalTimeDcs: arrivalTimeDcs,
          stopDcs: stopDcs);

      return flightSearchResult;
    } catch (e) {
      FlightSearchResult flightSearchResult = FlightSearchResult(
          pageSize: pageSize,
          alertMsg: alertMsg,
          totalFlights:totalFlights,
          searchResponses: searchResponses,
          priceDcs: priceDcs,
          sortingDcs: sortingDcs,
          airlineDcs: airlineDcs,
          departureTimeDcs: departureTimeDcs,
          arrivalTimeDcs: arrivalTimeDcs,
          stopDcs: stopDcs);

      return flightSearchResult;
    }
  }

  Future<FlightSearchResult> getFlightSearchResultsFiltered(
      FlightFilterBody flightFilterBody) async {
    int pageSize = 0;
    int totalFlights = 0;
    String alertMsg = "";
    List<FlightSearchResponse> searchResponses = [];
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointFilterFlights,
          flightFilterBody.toJson());

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["searchResponses"] != null) {
            for (var i = 0; i < response.data["searchResponses"].length; i++) {
              searchResponses.add(
                  mapFlightSearchResponse(response.data["searchResponses"][i]));
            }
          }
          if (response.data["pageSize"] != null) {
            pageSize = int.parse(response.data["pageSize"].toString());
          }
          if (response.data["alertMsg"] != null) {
            alertMsg = response.data["alertMsg"];
          }
          if (response.data["totalFlights"] != null) {
            alertMsg = response.data[""];
          }
        }
      }

      return FlightSearchResult(
          pageSize: pageSize,
          alertMsg: alertMsg,
          totalFlights: totalFlights,
          searchResponses: searchResponses,
          priceDcs: [],
          sortingDcs: [],
          airlineDcs: [],
          departureTimeDcs: [],
          arrivalTimeDcs: [],
          stopDcs: []);
    } catch (e) {
      return FlightSearchResult(
          pageSize: pageSize,
          totalFlights: totalFlights,
          alertMsg: alertMsg,
          searchResponses: searchResponses,
          priceDcs: [],
          sortingDcs: [],
          airlineDcs: [],
          departureTimeDcs: [],
          arrivalTimeDcs: [],
          stopDcs: []);
    }
  }

  Future<FlightSearchResult> getMoreOptions(int index, int objectId) async {
    List<FlightSearchResponse> searchResponses = [];

    int totalFlights = 0;
    int pageSize = 0;
    String alertMsg = "";

    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointGetMoreOptionFlights,
          {"objectID": objectId, "index": index});

      if (response.success) {
        if (response.data != null) {
          if (response.data["searchResponses"] != null) {
            for (var i = 0; i < response.data["searchResponses"].length; i++) {
              searchResponses.add(
                  mapFlightSearchResponse(response.data["searchResponses"][i]));
            }
          }
          if (response.data["pageSize"] != null) {
            pageSize = int.parse(response.data["pageSize"].toString());
          }
          if (response.data["alertMsg"] != null) {
            alertMsg = response.data["alertMsg"];
          }
          if (response.data["totalFlights"] != null) {
            totalFlights = response.data["totalFlights"];
          }
        }
      }

      FlightSearchResult flightSearchResult = FlightSearchResult(
          alertMsg: alertMsg,
          totalFlights: totalFlights,
          pageSize: pageSize,
          searchResponses: searchResponses,
          priceDcs: [],
          sortingDcs: [],
          airlineDcs: [],
          departureTimeDcs: [],
          arrivalTimeDcs: [],
          stopDcs: []);

      return flightSearchResult;
    } catch (e) {
      FlightSearchResult flightSearchResult = FlightSearchResult(
          alertMsg: alertMsg,
          pageSize: pageSize,
          totalFlights: totalFlights,
          searchResponses: searchResponses,
          priceDcs: [],
          sortingDcs: [],
          airlineDcs: [],
          departureTimeDcs: [],
          arrivalTimeDcs: [],
          stopDcs: []);
      return flightSearchResult;
    }
  }

  Future<FlightDetails> getFlightDetails(int index, int objectId) async {
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointGetDetailFlights,
          {"objectID": objectId, "index": index});

      FlightDetails flightDetails;
      print("response.data");
      print(response.data);
      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          flightDetails = mapFlightDetails(response.data);
          return flightDetails;
        }
      }
      throw response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr;
     } catch (e) {
      rethrow;
    }
  }

  Future<FlightPretravellerData> getPreTravellerData(int detailId) async {
    try {
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
    } catch (e) {
      return mapFlightPretravellerData({});
    }
  }

  Future<BookingRefData> setTravellerData(
      FlightTravellerData flightTravellerData) async {
    String bookingRef = "";
    bool isSeatSelection = false;
    bool isMealSelection = false;
    bool isExtraBaggageSelection = false;

    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointGetSaveTravellerData,
          flightTravellerData.toJson());

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
    } catch (e) {
      return BookingRefData(
        bookingRef: bookingRef,
        isSeatSelection: isSeatSelection,
        isMealSelection: isMealSelection,
        isExtraBaggageSelection: isExtraBaggageSelection,
      );
    }
  }


  Future<GetGatewayData> getPaymentGateways(String bookingRef) async {
    List<PaymentGateway> paymentGateways = [];
    List<BookingInfo> bookingInfo = [];
    List<String> alertMsg = [];
    FlightDetails flightDetails = mapFlightDetails({});
    HotelDetails hotelDetails = mapHotelDetails({});
    ActivityDetails activityDetails = mapActivityDetails({}, []);

    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointGetGateways,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isGateway"]) {
            response.data["_gatewaylist"].forEach((element) {
              if(element !=null){
                paymentGateways.add(mapPaymentGateway(element));
              }

            });
          }

          if (response.data["_flightservice"] != null) {
            if (response.data["_flightservice"]["_flightDetail"] != null) {
              flightDetails = mapFlightDetails(
                  response.data["_flightservice"]["_flightDetail"]);
            }
          }
          if (response.data["alertMsg"] != null) {
            response.data["alertMsg"].forEach((element) {
              if(element !=null){
                alertMsg.add(element);
              }

            });
          }

          if (response.data["_bookingInfo"] != null) {
            response.data["_bookingInfo"].forEach((element) {
              if(element !=null){
                bookingInfo.add(mapBookingInfo(element));
              }

            });
          }
        }
      }

      return GetGatewayData(
          hotelDetails: hotelDetails,
          activityDetails: activityDetails,
          paymentGateways: paymentGateways,
          alert: alertMsg,
          bookingInfo: bookingInfo,
          flightDetails: flightDetails);
    } catch (e) {
      return GetGatewayData(
          hotelDetails: hotelDetails,
          activityDetails: activityDetails,
          paymentGateways: paymentGateways,
          alert: alertMsg,
          bookingInfo: bookingInfo,
          flightDetails: flightDetails);
    }
  }

  Future<FlightAddonGetSeat> getSeats(String bookingRef) async {
    List<FlightAddonRoute> routes = [];
    List<FlightAddonPassenger> passengers = [];
    List<FlightAddonFlightClass> flightClass = [];

    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetSeats, {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["routes"] != null) {
            response.data["routes"].forEach((element) {
              if(element !=null){
                routes.add(mapFlightAddonRoute(element));
              }

            });
          }

          if (response.data["passengers"] != null) {
            response.data["passengers"].forEach((element) {
              if(element !=null){
                passengers.add(mapFlightAddonPassenger(element));
              }

            });
          }
          if (response.data["flightClass"] != null) {
            response.data["flightClass"].forEach((element) {
              if(element !=null){
                flightClass.add(mapFlightAddonFlightClass(element));
              }

            });
          }
        }
      }

      return FlightAddonGetSeat(
          routes: routes, passengers: passengers, flightClass: flightClass);
    } catch (e) {
      return FlightAddonGetSeat(
          routes: routes, passengers: passengers, flightClass: flightClass);
    }
  }

  Future<bool> setSeats(FlightAddonSetSeat flightAddonSetSeatData) async {
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointSaveSeat,
          flightAddonSetSeatData.toJson());

      if (response.success && response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setMeals(FlightAddonSetMeal flightAddonSetMealData) async {
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointSaveMeal,
          flightAddonSetMealData.toJson());

      if (response.success && response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setExtraBuggage(
      FlightAddonSetExtraPackage flightAddonSetExtraPackage) async {
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointSaveExtraLuaggage,
          flightAddonSetExtraPackage.toJson());

      if (response.success && response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<FlightAddonGetMeal> getMeals(String bookingRef) async {
    List<FlightAddonRoute> routes = [];
    List<FlightAddonPassenger> passengers = [];
    List<FlightAddonMeal> meals = [];

    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetMeals, {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["routes"] != null) {
            response.data["routes"].forEach((element) {
              if(element !=null){
                routes.add(mapFlightAddonRoute(element));
              }

            });
          }

          if (response.data["passengers"] != null) {
            response.data["passengers"].forEach((element) {
              if(element !=null){
                passengers.add(mapFlightAddonPassenger(element));
              }

            });
          }
          if (response.data["meals"] != null) {
            response.data["meals"].forEach((element) {
              if(element !=null){
                meals.add(mapFlightAddonMeal(element));
              }

            });
          }
        }
      }

      return FlightAddonGetMeal(
          routes: routes, passengers: passengers, meals: meals);
    } catch (e) {
      return FlightAddonGetMeal(
          routes: routes, passengers: passengers, meals: meals);
    }
  }

  Future<FlightAddonGetExtraPackage> getExtraPackage(String bookingRef) async {
    List<FlightAddonRoute> routes = [];
    List<FlightAddonPassenger> passengers = [];
    List<FlightAddonExtraPackage> extraPackages = [];

    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetExtraLuaggage,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["routes"] != null) {
            response.data["routes"].forEach((element) {
              if(element !=null){
                routes.add(mapFlightAddonRoute(element));
              }

            });
          }

          if (response.data["passengers"] != null) {
            response.data["passengers"].forEach((element) {
              if(element !=null){
                passengers.add(mapFlightAddonPassenger(element));
              }

            });
          }
          if (response.data["extraPackages"] != null) {
            response.data["extraPackages"].forEach((element) {
              if(element !=null){
                extraPackages.add(mapFlightAddonExtraPackage(element));
              }

            });
          }
        }
      }

      return FlightAddonGetExtraPackage(
          routes: routes, passengers: passengers, extraPackages: extraPackages);
    } catch (e) {
      return FlightAddonGetExtraPackage(
          routes: routes, passengers: passengers, extraPackages: extraPackages);
    }
  }

  Future<bool> checkGatewayStatus(String bookingRef) async {
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointCheckGatewayStatus,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isSuccess"] != null) {
            return response.data["isSuccess"];
          }
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<PaymentConfirmationData> getConfirmationData(String bookingRef) async {
    try {
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointConfirmation,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          PaymentConfirmationData paymentConfirmationData =
              mapPaymentpdfLinkData(response.data, true);
          return paymentConfirmationData;
        }
      }

      return mapPaymentpdfLinkData({}, false);
    } catch (e) {
      return mapPaymentpdfLinkData({}, false);
    }
  }

  Future<PaymentGatewayUrlData> setPaymentGateway(
      String processID, String paymentCode, String bookingRef) async {
    try {
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
    } catch (e) {
      return mapPaymentGatewayUrlData({});
    }
  }

  Future<List<RecommendedPackage>> getRecommended(int pageId) async {
    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetViewAllRecommeded,
          {"pageid": pageId.toString()});
      List<RecommendedPackage> recommendedPackages = [];
      if (response.success) {
        if (response.data != null) {
          if (response.data["records"] != null) {
            response.data["records"].forEach((element) {
              if(element !=null){
                recommendedPackages.add(mapRecommendedPackage(element));
              }

            });
            return recommendedPackages;
          }
        }
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<TravelStory>> getTravelStories(int pageId) async {
    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetViewAllRecommeded,
          {"pageid": pageId.toString()});
      List<TravelStory> travelStories = [];
      if (response.success) {
        if (response.data != null) {
          if (response.data["records"] != null) {
            response.data["records"].forEach((element) {
              if(element !=null){
                travelStories.add(mapTravelStory(element));
              }

            });
            return travelStories;
          }
        }
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<PopularDestination>> getPopularDestinations(int pageId) async {
    try {
      FlyternHttpResponse response = await getRequest(
          FlightBookingHttpRequestEndpointGetViewAllRecommeded,
          {"pageid": pageId.toString()});
      List<PopularDestination> popularDestination = [];
      if (response.success) {
        if (response.data != null) {
          if (response.data["records"] != null) {
            response.data["records"].forEach((element) {
              if(element !=null){
                popularDestination.add(mapPopularDestination(element));
              }

            });
            return popularDestination;
          }
        }
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
