// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Constant {
  static Color primaryColor = const Color(0xFFFE7D55);
  static Color fontGrayBold = const Color(0xFF444853);
  static Color redFontColor = const Color(0xffCA252B);
  static Color blackFont = const Color(0xFF343434);
  static Color fontGraylight = const Color(0xFF757575);
  static Color background = const Color(0xFFffffff);
  static Color darkBackground = const Color(0xFFF4F4F4);

  static List<Color> colorGrediant = const [
    Color(0xFFFE7D55),
    Color(0xFFFE7D55),
    Color(0xFFFE7D55),
    Color(0xFFFE7D55),
  ];

  // font color
  // buttons
  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.white),
      ),
    ),
  );
  static ButtonStyle getbuttonStyleRounded(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }

  // font style
// grey

  static TextStyle bodyLineGrey14 = TextStyle(
      fontSize: 14,
      fontFamily: "Almarai",
      color: Color(0xffCECBCB),
      fontWeight: FontWeight.w500);
  static TextStyle bodyLineGrey10 = TextStyle(
      fontSize: 10,
      fontFamily: "Almarai",
      color: Color(0xffCECBCB),
      fontWeight: FontWeight.w500);

  // whiet text
  static TextStyle headLineWhite = TextStyle(
      fontSize: 30,
      fontFamily: "Almarai",
      color: Colors.white,
      fontWeight: FontWeight.bold);
  static TextStyle bodyTextWhite16 = TextStyle(
      fontSize: 16,
      fontFamily: "Almarai",
      color: Colors.white,
      fontWeight: FontWeight.bold);

  // primary text
  static TextStyle bodyTextGreen32 = TextStyle(
      fontSize: 32,
      fontFamily: "Almarai",
      color: primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle bodyTextGreen14 = TextStyle(
      fontSize: 14,
      fontFamily: "Almarai",
      color: primaryColor,
      fontWeight: FontWeight.bold);
//
  static TextStyle bodyTextRed16 = TextStyle(
      fontSize: 16,
      fontFamily: "Almarai",
      color: redFontColor,
      fontWeight: FontWeight.bold);
  static TextStyle bodyLineRed10 = TextStyle(
      fontSize: 10,
      fontFamily: "Almarai",
      color: Color(0xffCECBCB),
      fontWeight: FontWeight.w600);
  //
  static TextStyle bodyText20 = TextStyle(
      fontSize: 20,
      fontFamily: "Almarai",
      color: blackFont,
      fontWeight: FontWeight.bold);
  static TextStyle bodyText16 = TextStyle(
      fontSize: 16,
      fontFamily: "Almarai",
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle bodyText14 = TextStyle(
      fontSize: 14,
      fontFamily: "Almarai",
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle bodyText10 = TextStyle(
      fontSize: 10,
      fontFamily: "Almarai",
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static Future pushReplacment(BuildContext context, Widget screen) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => screen));
  }

  static Future push(BuildContext context, Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (ctx) => screen));
  }

  static pop(BuildContext context) {
    return Navigator.pop(
      context,
    );
  }

  static popWithBool(BuildContext context, bool result) {
    return Navigator.pop<bool>(context, result);
  }

  static popTofirst(BuildContext context) {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static CircularProgressIndicator indicator = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Constant.primaryColor));

  static CircularProgressIndicator indicatorRed = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Constant.redFontColor));
  static const kPaddingA2 = EdgeInsets.all(2);
  static const kPaddingA4 = EdgeInsets.all(4);
  static const kPaddingA8 = EdgeInsets.all(8);
  static const kPaddingA16 = EdgeInsets.all(16);

  static const kPaddingV2 = EdgeInsets.symmetric(vertical: 2);
  static const kPaddingV4 = EdgeInsets.symmetric(vertical: 4);
  static const kPaddingH8 = EdgeInsets.symmetric(horizontal: 8);
  static const kPaddingH16 = EdgeInsets.symmetric(horizontal: 16);

  static const kPaddingH22 = EdgeInsets.symmetric(horizontal: 22);
  static const kPaddingH30 = EdgeInsets.symmetric(horizontal: 30);

  static const kMargin2 = EdgeInsets.all(2);
  static const kMargin4 = EdgeInsets.all(4);
  static const kMargin8 = EdgeInsets.all(8);
  static const kMargin12 = EdgeInsets.all(12);
  static const kMargin16 = EdgeInsets.all(16);
  static MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

enum ErrorOrGreenState { error, green }
