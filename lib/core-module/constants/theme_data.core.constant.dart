 import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'dart:ui';


ThemeData getThemeData( String type, String locale) {
  print("locale is");
  print(locale);
  return type == 'light'
      ? ThemeData(
          snackBarTheme:
              const SnackBarThemeData(backgroundColor: flyternBackgroundOffWhite),
          brightness: Brightness.light,
          primaryColor: flyternPrimaryColor,
          fontFamily: locale == 'en'
              ? flyternDefaultFontFamilyEnglish
              : flyternDefaultFontFamilyArabic,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: flyternSecondaryColor),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: flyternFontSize24,
                fontWeight: flyternFontWeightBold ),
            headlineMedium: TextStyle(
                fontSize: flyternFontSize20,
                fontWeight: flyternFontWeightMedium,
                color: flyternGrey80),
            labelLarge: TextStyle(
                fontSize: flyternFontSize14,
                fontWeight: flyternFontWeightMedium,
                color: flyternGrey60),
            labelSmall: TextStyle(
                fontSize: flyternFontSize12,
                fontWeight: flyternFontWeightLight,
                color: flyternGrey60),
            bodyMedium: TextStyle(
                fontSize: flyternFontSize16,
                height: 1.4,
                fontWeight: flyternFontWeightRegular,
                color: flyternGrey80),
            // labelSmall
            //  bodyMedium
          ),
          buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusSmall*100))),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: flyternPrimaryColor, width: 1)),
                  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                      fontWeight: flyternFontWeightMedium, color: flyternPrimaryColor)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(flyternPrimaryColor),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          horizontal: flyternSpaceLarge, vertical: flyternSpaceMedium)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(flyternBorderRadiusExtraSmall))),)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                          horizontal: flyternSpaceLarge,
                          vertical: locale=='en'? flyternSpaceMedium*1.1:flyternSpaceMedium)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(flyternPrimaryColor))),
          textButtonTheme: TextButtonThemeData(

              style: ButtonStyle(

                  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                       decoration: TextDecoration.underline,
                      fontSize: flyternFontSize12,
                      fontWeight: flyternFontWeightLight,
                      decorationThickness: 2,
                      color: flyternGrey40,
                      height: 1.3)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                  foregroundColor: MaterialStateProperty.all<Color>(flyternGrey60),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent))),
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: flyternGrey20,
              contentPadding:
              const EdgeInsets.symmetric(vertical: flyternSpaceMedium, horizontal: flyternSpaceLarge ),
              labelStyle: TextStyle(color: flyternGrey80),
              hintStyle: TextStyle(color: flyternGrey60),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall ),
                  borderSide: BorderSide(width: .5,color: flyternGrey20 )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall ),
                  borderSide: BorderSide(width: .5, color: flyternGrey40)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall ),
                  borderSide: const BorderSide(
                      color:flyternGuideRed, width: 1.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall ),
                  borderSide: const BorderSide(
                      color: flyternGrey40, width: 1.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall ),
                  borderSide: const BorderSide(
                      color: flyternGuideRed, width: 1.0)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall ),
                  borderSide: const BorderSide(
                      color: flyternGrey40, width: .50)) ),
          scaffoldBackgroundColor: flyternBackgroundWhite,

    appBarTheme: AppBarTheme(
        titleSpacing: 0,
        titleTextStyle:TextStyle(
            fontWeight: flyternFontWeightBold,
            fontSize:locale=='en'?
            flyternFontSize20:flyternFontSize20,
            fontFamily: locale == 'en'
          ? flyternDefaultFontFamilyEnglish
          : flyternDefaultFontFamilyArabic,
          color: flyternGrey80
        ),
        backgroundColor: flyternBackgroundWhite,
        foregroundColor: flyternGrey80,
        // shape: ContinuousRectangleBorder(
        //     borderRadius:BorderRadius.only(
        //         bottomLeft: Radius.circular(flyternSpaceLarge*2.5),
        //         bottomRight: Radius.circular(flyternSpaceLarge*2.5))
        // ),
        centerTitle: false,
        elevation: 0.0),
        )
      : ThemeData(
        scaffoldBackgroundColor: flyternBackgroundWhite,
          snackBarTheme:
              const SnackBarThemeData(backgroundColor: flyternBackgroundOffWhite),
          brightness: Brightness.light,
          primaryColor: flyternPrimaryColor,
          fontFamily: locale == 'en'
              ? flyternDefaultFontFamilyEnglish
              : flyternDefaultFontFamilyArabic,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: flyternSecondaryColor),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: flyternFontSize24,
                fontWeight: flyternFontWeightBold,
                color: flyternGrey80),
            // labelSmall
          ),
          buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusSmall*100))),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: flyternPrimaryColor, width: 1)),
                  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                      fontWeight: flyternFontWeightMedium, color: flyternPrimaryColor)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(flyternPrimaryColor),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          horizontal: flyternSpaceLarge, vertical: flyternSpaceMedium)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(flyternBorderRadiusExtraSmall))),)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                          horizontal: flyternSpaceLarge,
                            vertical: locale=='en'? flyternSpaceMedium*1.1:flyternSpaceMedium)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(flyternPrimaryColor))),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1)),
    appBarTheme: AppBarTheme(
        titleSpacing: 0,
        titleTextStyle:TextStyle(
            fontWeight: flyternFontWeightBold,
            fontSize:locale=='en'?
            flyternFontSize20:flyternFontSize20,
            fontFamily: locale == 'en'
                ? flyternDefaultFontFamilyEnglish
                : flyternDefaultFontFamilyArabic,
            color: flyternGrey80
        ),
        backgroundColor: flyternBackgroundWhite,
        foregroundColor: flyternGrey80,
        // shape: ContinuousRectangleBorder(
        //     borderRadius:BorderRadius.only(
        //         bottomLeft: Radius.circular(flyternSpaceLarge*2.5),
        //         bottomRight: Radius.circular(flyternSpaceLarge*2.5))
        // ),
        centerTitle: false,
        elevation: 0.0),
        );
}
