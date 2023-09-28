import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';

class CoreLanguageSelector extends StatelessWidget {
  const CoreLanguageSelector({super.key});

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
                  child:   Text("Continue In English" ), onPressed: () {
                print("en pressed");
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
                  onPressed: () {
                    print("ar pressed");

                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: flyternSpaceLarge, vertical: flyternSpaceMedium*1)),
                  ),
                  child:Text("كاملة باللغة العربية"  )),
            ),
          ],
        ),
      ),
    );
  }
}
