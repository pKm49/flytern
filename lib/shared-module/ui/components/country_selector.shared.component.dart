import 'package:flutter/material.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CountrySelector extends StatelessWidget {

  final Function(Country? country) countrySelected;
  final bool? isGlobal;
  CountrySelector({super.key, required this.countrySelected, this.isGlobal});
  TextEditingController searchController = TextEditingController();

  final sharedController = Get.find<SharedController>();

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
                print("searchController clicked");
                sharedController.updateCountryListByQuery(searchController.value.text);
              },
                keyboardType: TextInputType.text,
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Ionicons.search_outline),
                  labelText: "search".tr,
                )),
            addVerticalSpace(flyternSpaceMedium ),
            Expanded(
              child: ListView(
                children: [

                  for(var i =0; i<sharedController.countriesToShow.length;i++)
                    InkWell(
                      onTap: () async {
                        print("countriesToShow");
                        print(sharedController.countriesToShow[i].toJson());
                        countrySelected(sharedController.countriesToShow[i]);
                        if(isGlobal == null || isGlobal == true){
                          await sharedController.changeCountry(sharedController.countriesToShow[i]);
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                        ),
                        padding: EdgeInsets.symmetric(vertical: flyternSpaceSmall),
                        child: Row(children: [

                          Image.network(sharedController.countriesToShow[i].flag, width: 40),
                          addHorizontalSpace(flyternSpaceMedium),
                          Expanded(
                              child: Text(
                                  Localizations.localeOf(context).languageCode.toString() ==
                                      'en'?
                                  sharedController.countriesToShow[i].countryName:
                                  sharedController.countriesToShow[i].countryName_Ar,
                                  maxLines: 2,
                                  style: getBodyMediumStyle(context))),
                          addHorizontalSpace(flyternSpaceSmall),
                          Text("( ${sharedController.countriesToShow[i].code} )",
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
