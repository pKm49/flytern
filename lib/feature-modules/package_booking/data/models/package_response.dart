import 'package:flytern/feature-modules/package_booking/data/models/package_data.dart';
import 'package:flytern/shared-module/models/country.dart';


class PackageResponse {

  final List<PackageData> packages;
  final List<Country> destinations;


  PackageResponse({
    required this.packages,
    required this.destinations
  });

}

PackageResponse mapPackageResponse(dynamic payload){

  List<PackageData> packages = [];
  List<Country> destinations = [];

  if(payload["packages"] != null){
    payload["packages"].forEach((element) {
      packages.add(mapPackageData(element));
    });
  }

  if(payload["destinations"] != null){
    payload["destinations"].forEach((element) {
      destinations.add(mapCountry(element));
    });
  }

  return PackageResponse(
    packages :packages,
    destinations :destinations
  );

}
