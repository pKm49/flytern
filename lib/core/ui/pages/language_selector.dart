import 'package:flutter/material.dart';
import 'package:flytern/core/controllers/core_controller.dart';
import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class CoreLanguageSelector extends StatelessWidget {
    CoreLanguageSelector({super.key});

  final coreController = Get.put(CoreController());


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      padding: flyternLargePaddingAll*2.5,
      color: flyternBackgroundWhite,
      child: Center(
        child: Wrap(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child:   Text("Continue In English" ),
                onPressed: () async {
                  await coreController.changeLanguage(Lang_English);
                  Get.toNamed(Approute_authSelector);

                },
                style: ButtonStyle(
                   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                            horizontal: flyternSpaceLarge, vertical: flyternSpaceMedium*1.2)),
                    backgroundColor: MaterialStateProperty.all<Color>(flyternSecondaryColor)
                ),),
            ),
            SizedBox(height: flyternSpaceLarge,width: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    print("ar pressed");
                    await coreController.changeLanguage(Lang_Arabic);
                    Get.toNamed(Approute_authSelector);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: flyternSpaceLarge, vertical: flyternSpaceMedium*.9)),
                  ),
                  child:Text("اللغه العربيه"  )),
            ),
          ],
        ),
      ),
    );
  }
}
