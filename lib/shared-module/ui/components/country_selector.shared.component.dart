import 'package:flutter/material.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CountrySelector extends StatefulWidget {

  final Function(Country  country) countrySelected;
  final bool  isMobile;
  final bool isGlobal;
  CountrySelector({super.key, required this.countrySelected,
    required this.isMobile,required this.isGlobal});

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  TextEditingController searchController = TextEditingController();

  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedController.resetCountryList();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      ()=> Container(
        height: screenheight*.85,
        width: screenwidth,
        padding: flyternLargePaddingAll,
        child: Column(
          children: [

              Text("select_country".tr,
                  style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold)),
            addVerticalSpace(flyternSpaceMedium ),

            TextFormField(
              onChanged: (String? value){
                 sharedController.updateCountryListByQuery(searchController.value.text,widget.isMobile);
              },
                keyboardType: TextInputType.text,
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Ionicons.search_outline),
                  labelText: "search_countries".tr,
                )),
            addVerticalSpace(flyternSpaceMedium ),
            Expanded(
              child: ListView(
                children: [

                  for(var i =0; i<(
                      widget.isMobile?
                      sharedController.mobileCountriesToShow.length:
                      sharedController.countriesToShow.length);i++)
                    InkWell(
                      onTap: () async {
                        if(  widget.isGlobal == true){
                          await sharedController.changeMobileCountry(
                              widget.isMobile?
                              sharedController.mobileCountriesToShow[i]:
                              sharedController.countriesToShow[i]);
                        }else{
                          widget.countrySelected(widget.isMobile?
                          sharedController.mobileCountriesToShow[i]:
                          sharedController.countriesToShow[i]);
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                        ),
                        padding: EdgeInsets.symmetric(vertical: flyternSpaceSmall),
                        child: Row(children: [

                          Image.network(
                              widget.isMobile?sharedController.mobileCountriesToShow[i].flag:
                              sharedController.countriesToShow[i].flag, width: 40),
                          addHorizontalSpace(flyternSpaceMedium),
                          Expanded(
                              child: Text(
                                  Localizations.localeOf(context).languageCode.toString() ==
                                      'en'?
                                  (
                                      widget.isMobile?
                                      sharedController.mobileCountriesToShow[i].countryName:
                                      sharedController.countriesToShow[i].countryName):
                                  (
                                      widget.isMobile?
                                      sharedController.mobileCountriesToShow[i].countryName_Ar:
                                      sharedController.countriesToShow[i].countryName_Ar),
                                  maxLines: 2,
                                  style: getBodyMediumStyle(context))),
                          addHorizontalSpace(flyternSpaceSmall),
                          Text("( ${
                              widget.isMobile?
                              sharedController.mobileCountriesToShow[i].code:
                              sharedController.countriesToShow[i].code} )",
                              style: getBodyMediumStyle(context)),

                        ],),
                      ),
                    )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
