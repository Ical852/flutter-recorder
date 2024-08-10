import 'package:flutter/material.dart';
import 'package:flutterrecorder/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get black => copyWith(color: blackColor);
  TextStyle get white => copyWith(color: whiteColor);
  TextStyle get grey => copyWith(color: greyColor);

  TextStyle get light => copyWith(fontWeight: fontLight);
  TextStyle get regularF => copyWith(fontWeight: fontRegular);
  TextStyle get mediumF => copyWith(fontWeight: fontMedium);
  TextStyle get semiBold => copyWith(fontWeight: fontSemiBold);
  TextStyle get bold => copyWith(fontWeight: fontBold);
  TextStyle get extraBold => copyWith(fontWeight: fontBold);
  TextStyle get blackBold => copyWith(fontWeight: fontBlackBold);
}

TextStyle poppins = GoogleFonts.poppins();

TextStyle xSmall = poppins.copyWith(fontSize: xSmallSize);
TextStyle small = poppins.copyWith(fontSize: smallSize);
TextStyle regular = poppins.copyWith(fontSize: regularSize);
TextStyle medium = poppins.copyWith(fontSize: mediumSize);
TextStyle base = poppins.copyWith(fontSize: baseSize);
TextStyle mega = poppins.copyWith(fontSize: megaSize);
TextStyle extra = poppins.copyWith(fontSize: extraSize);
