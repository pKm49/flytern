import 'dart:ui';

 import 'package:flytern/core/services/utility-services/app_localization.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle getHeadlineLargeStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.headlineLarge!.copyWith(
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize24:flyternFontSize20,
      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getHeadlineMediumStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.headlineMedium!.copyWith(
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize20:flyternFontSize16,
      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getBodyMediumStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.bodyMedium!.copyWith(
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize16:flyternFontSize14,

      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getLabelLargeStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize14:flyternFontSize12,
      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getLabelSmallStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelSmall!.copyWith(
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize12:flyternFontSize12,
      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getElevatedButtonLabelStylePrimary(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      color: flyternPrimaryColor,
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize14:flyternFontSize12,
      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getElevatedButtonLabelStyleLight(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      color: flyternGrey20,
      fontSize:AppLocalization.of(context).locale.languageCode=='en'?
      flyternFontSize14:flyternFontSize12,
      fontFamily:AppLocalization.of(context).locale.languageCode=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}
