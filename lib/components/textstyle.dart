import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

getNavStyle(BuildContext context) {
  return GoogleFonts.firaSansCondensed(
      color: Color(0xFF0C4546),
      fontWeight: FontWeight.bold,
      fontSize: ResponsiveValue(context, defaultValue: 10.0, valueWhen: [
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 18.0),
        Condition.equals(name: DESKTOP, value: 20.0),
        Condition.largerThan(name: DESKTOP, value: 26.0)
      ]).value);
}
