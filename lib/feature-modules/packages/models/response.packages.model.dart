import 'package:flytern/feature-modules/packages/models/data.packages.model.dart';
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
      if(element != null){
        packages.add(mapPackageData(element));
      }

    });
  }

  if(payload["destinations"] != null){
    payload["destinations"].forEach((element) {
      if(element != null){
        destinations.add(mapCountry(element));
      }

    });
  }

  return PackageResponse(
    packages :packages,
    destinations :destinations
  );

}
