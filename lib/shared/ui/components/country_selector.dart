import 'package:flutter/material.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CountrySelector extends StatelessWidget {
    CountrySelector({super.key});
  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight*.85,
      width: screenwidth,
      padding: flyternLargePaddingAll,
      child: Column(
        children: [

            Text("select_country".tr,
                style: getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold)),
          addVerticalSpace(flyternSpaceMedium ),

          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Ionicons.search_outline),
                labelText: "search".tr,
              )),
          addVerticalSpace(flyternSpaceMedium ),
          Expanded(
            child: ListView(
              children: [

                for(var i =0; i<sharedController.countries.length;i++)
                  InkWell(
                    onTap: () async {
                      await sharedController.changeCountry(sharedController.countries[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: .5,color: flyternGrey40))
                      ),
                      padding: EdgeInsets.symmetric(vertical: flyternSpaceSmall),
                      child: Row(children: [

                        Image.network(sharedController.countries[i].flag, width: 40),
                        addHorizontalSpace(flyternSpaceMedium),
                        Expanded(
                            child: Text(
                                Localizations.localeOf(context).languageCode.toString() ==
                                    'en'?
                                sharedController.countries[i].countryName:
                                sharedController.countries[i].countryName_Ar,
                                maxLines: 2,
                                style: getBodyMediumStyle(context))),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text("( ${sharedController.countries[i].code} )",
                            style: getBodyMediumStyle(context)),

                      ],),
                    ),
                  )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
