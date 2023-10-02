import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// flutter component styles

const flyternFontWeightExtraLight = FontWeight.w200;
const flyternFontWeightLight = FontWeight.w300;
const flyternFontWeightRegular = FontWeight.w400;
const flyternFontWeightMedium = FontWeight.w500;
const flyternFontWeightBold = FontWeight.w700;

const flyternLargePaddingAll = EdgeInsets.all(flyternSpaceLarge);
const flyternLargePaddingHorizontal =
    EdgeInsets.symmetric(horizontal: flyternSpaceLarge);
const flyternLargePaddingVertical =
    EdgeInsets.symmetric(vertical: flyternSpaceLarge);
const flyternMediumPaddingAll = EdgeInsets.all(flyternSpaceMedium);
const flyternMediumPaddingVertical =
    EdgeInsets.symmetric(vertical: flyternSpaceMedium);
const flyternMediumPaddingHorizontal =
    EdgeInsets.symmetric(horizontal: flyternSpaceMedium);
const flyternMediumPaddingTop = EdgeInsets.only(top: flyternSpaceMedium);
const flyternSmallPaddingAll = EdgeInsets.all(flyternSpaceSmall);
const flyternSmallPaddingVertical =
    EdgeInsets.symmetric(vertical: flyternSpaceSmall);
const flyternSmallPaddingHorizontal =
EdgeInsets.symmetric(horizontal: flyternSpaceSmall);
const flyternExtraSmallPaddingAll = EdgeInsets.all(flyternSpaceExtraSmall);
const flyternExtraSmallPaddingVertical =
    EdgeInsets.symmetric(vertical: flyternSpaceExtraSmall);

var flyternContainerShadow = [
  const BoxShadow(
    color: flyternGrey80Shadow24,
    offset: Offset(0, 4.0),
    blurRadius: flyternBlurRadiusLarge,
  ),
];

var flyternContainerTopShadow = [
  const BoxShadow(
    color: flyternGrey80Shadow24,
    offset: Offset(0, -4.0),
    blurRadius: flyternBlurRadiusLarge,
  ),
];

var flyternItemShadow = [
  const BoxShadow(
    color: flyternGrey80Shadow24,
    offset: Offset(0, 4.0),
    blurRadius: flyternBlurRadiusSmall,
  ),
];

var flyternDefaultBorderAll = Border.all(color: flyternGrey40, width: .2);

var flyternDefaultBorderTopOnly = const Border(
  top: BorderSide(
    color: flyternGrey40,
    width: 1.0,
  ),
);

var flyternDefaultBorderBottomOnly = const Border(
  bottom: BorderSide(
    color: flyternGrey40,
    width: 1.0,
  ),
);

var flyternShadowedContainerLargeDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  boxShadow: flyternContainerShadow,
  borderRadius: BorderRadius.circular(flyternBorderRadiusLarge),
);

var flyternTopShadowedContainerLargeDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  boxShadow: flyternContainerTopShadow,
  borderRadius: BorderRadius.circular(flyternBorderRadiusLarge),
);

var flyternShadowedContainerMediumDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  boxShadow: flyternContainerShadow,
  borderRadius: BorderRadius.circular(flyternBorderRadiusMedium),
);

var flyternBorderedContainerDarkMediumDecoration = BoxDecoration(
  color: flyternGrey20,
  border: flyternDefaultBorderAll,
  borderRadius: BorderRadius.circular(flyternBorderRadiusMedium),
);

var flyternShadowedContainerSmallDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  border: flyternDefaultBorderAll,
  boxShadow: flyternContainerShadow,
  borderRadius: BorderRadius.circular(flyternBorderRadiusSmall),
);

var flyternBorderedContainerDarkSmallDecoration = BoxDecoration(
  color: flyternGrey20,
  border: flyternDefaultBorderAll,
  borderRadius: BorderRadius.circular(flyternBorderRadiusSmall),
);

var flyternShadowedContainerSmallWithBorderDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  boxShadow: flyternContainerShadow,
  border: flyternDefaultBorderAll,
  borderRadius: BorderRadius.circular(flyternBorderRadiusSmall),
);

var flyternBorderedContainerLargeDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  border: flyternDefaultBorderAll,
  borderRadius: BorderRadius.circular(flyternBorderRadiusLarge),
);

var flyternBorderedContainerMediumDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  border: flyternDefaultBorderAll,
  borderRadius: BorderRadius.circular(flyternBorderRadiusMedium),
);

var flyternBorderedContainerSmallDecoration = BoxDecoration(
  color: flyternBackgroundWhite,
  border: flyternDefaultBorderAll,
  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
);

var flyternElevatedButtonStyleDark =
    ElevatedButton.styleFrom(backgroundColor: flyternGrey80);

var flyternOutlinedButtonStylePrimary = OutlinedButton.styleFrom(
  side: BorderSide(color: flyternPrimaryColor, width: 2),
  textStyle: TextStyle(
      fontWeight: flyternFontWeightMedium, color: flyternPrimaryColor),
);

var noBorderInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: flyternSpaceSmall),
    labelStyle: TextStyle(color: flyternGrey80),
    hintStyle: TextStyle(color: flyternGrey60),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(flyternBorderRadiusSmall * 100),
        borderSide: BorderSide(width: 0, color: Colors.transparent)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(flyternBorderRadiusSmall * 100),
        borderSide: BorderSide(width: 0, color: Colors.transparent)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(flyternBorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(flyternBorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(flyternBorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(flyternBorderRadiusSmall * 100),
        borderSide: const BorderSide(color: Colors.transparent, width: 0)));

var bottomBorderInputDecoration = InputDecoration(
    filled: true,
    fillColor: flyternBackgroundWhite,

    contentPadding: const EdgeInsets.symmetric(vertical: flyternSpaceSmall,
        horizontal: flyternSpaceMedium),
    labelStyle: TextStyle(color: flyternGrey80),
    hintStyle: TextStyle(color: flyternGrey60),
    border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(width: .5,color: flyternGrey20 )),
    disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(width: .5, color: flyternGrey40)),
    errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color:flyternGuideRed, width: 1.0)),
    focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color: flyternGrey40, width: 1.0)),
    focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color: flyternGuideRed, width: 1.0)),
    enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(
            color: flyternGrey40, width: .50)));
