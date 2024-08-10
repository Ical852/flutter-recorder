import 'package:flutter/material.dart';
import 'package:flutterrecorder/shared/constants.dart';
import 'package:flutterrecorder/shared/text_styles.dart';

dynamic nullChecker(dynamic check) {
  if (check == null) return null;
  return check;
}

bool isNotNull(dynamic check) {
  return check != null;
}

Color getColorType(type) {
  if (type == 'danger') {
    return errorColor;
  } else if (type == 'info') {
    return infoColor;
  } else {
    return successColor;
  }
}

void showGLobalAlert(type, text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      text,
      style: regular.white.bold,
      textAlign: TextAlign.center,
    ),
    backgroundColor: getColorType(type),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8)
      )
    ),
  ));
}

double getWH(BuildContext context, String type) {
  var size = MediaQuery.of(context).size;

  if (type == 'width') return size.width;
  return size.height;
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1); 
}
