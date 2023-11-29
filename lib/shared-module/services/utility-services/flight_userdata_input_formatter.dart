import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlightUserDataTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase().replaceAll(RegExp(r'[^\w\s]+'),''),
      selection: newValue.selection,
    );
  }
}