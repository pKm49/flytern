import 'dart:ui';

 import 'package:flytern/core/services/utility-services/app_localization.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle getHeadlineLargeStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.headlineLarge!.copyWith(
      fontSize:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternFontSize24:flyternFontSize20,
      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getHeadlineMediumStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.headlineMedium!.copyWith(
      fontSize:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternFontSize20:flyternFontSize16,
      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getBodyMediumStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.bodyMedium!.copyWith(
      fontSize:Localizations.localeOf(context)
          .languageCode
          .toString()=='en'?
      flyternFontSize16:flyternFontSize14,

      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getLabelLargeStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      fontSize:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternFontSize14:flyternFontSize12,
      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getLabelSmallStyle(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelSmall!.copyWith(
      fontSize:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternFontSize12:flyternFontSize12,
      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getElevatedButtonLabelStylePrimary(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      color: flyternPrimaryColor,
      fontSize:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternFontSize14:flyternFontSize12,
      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}

TextStyle getElevatedButtonLabelStyleLight(BuildContext context){
  TextTheme _textTheme = Theme.of(context).textTheme;

  return _textTheme.labelLarge!.copyWith(
      color: flyternGrey20,
      fontSize:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternFontSize14:flyternFontSize12,
      fontFamily:Localizations.localeOf(context)
                .languageCode
                .toString()=='en'?
      flyternDefaultFontFamilyEnglish:flyternDefaultFontFamilyArabic);
}
