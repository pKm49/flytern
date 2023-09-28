import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';

class CoreLanguageSelector extends StatelessWidget {
  const CoreLanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      padding: flyternLargePaddingAll,
      color: flyternBackgroundWhite,
      child: Center(
        child: Wrap(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child:   Text("Continue In English" ), onPressed: () {
                print("en pressed");
              }),
            ),
            SizedBox(height: flyternSpaceLarge,width: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    print("ar pressed");

                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(flyternSecondaryColor)
                  ),
                  child:Text("كاملة باللغة العربية"  )),
            ),
          ],
        ),
      ),
    );
  }
}
