import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flutter/material.dart';

class PrePostIconButton extends StatelessWidget {
  final num? specialColor;
  final String? border;
  final String? theme;
  final IconData? preIconData;
  final IconData? postIconData;
  final String buttonTitle;
  final GestureTapCallback onPressed;

  const PrePostIconButton(
      {super.key,
      required this.specialColor,
      required this.theme,
      required this.border,
      required this.preIconData,
        required this.onPressed,
      required this.postIconData,
      required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
          padding:  flyternMediumPaddingVertical,
          decoration: BoxDecoration(
              border:border!=""? Border(
                  bottom:BorderSide(width: border!.contains('bottom')? .15 :0.0, color:
                  theme=='light'? flyternGrey20: flyternGrey40 )):null,
              color: Colors.transparent, ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(visible: preIconData != null, child: Padding(
                padding:   EdgeInsets.only(
                    left: (Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'? flyternSpaceMedium:0 ),
                    right:( Localizations.localeOf(context)
                        .languageCode
                        .toString() ==
                        'ar'?0: flyternSpaceMedium) ),
                child: Icon(preIconData,color:
                specialColor ==1?flyternGuideRed:
                specialColor ==2?flyternPrimaryColor:
                theme=='light'? flyternBackgroundOffWhite: flyternGrey40),
              )),
              Expanded(child: Text(buttonTitle,textAlign: TextAlign.start ,

                  style: getBodyMediumStyle(context).copyWith(color:
                  specialColor ==1?flyternGuideRed:
                  specialColor ==2?flyternPrimaryColor:
                  theme=='light'? flyternBackgroundOffWhite: flyternBlack,fontWeight:theme=='light'? flyternFontWeightLight : FontWeight.normal))),
              Visibility(visible: postIconData != null, child: Icon(postIconData,color:
              specialColor ==1?flyternGuideRed:
              specialColor ==2?flyternPrimaryColor:
              theme=='light'? flyternGrey20: flyternGrey60))
            ],
          )),
    );
  }
}
