import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppStyles {


  static const Color mainColor = Color(0xff0066D9);

  /// RGB 56, 58, 81
  static const Color mainColorDark = Color(0xff383a51);

  /// RGB 51, 196, 168
  static const Color secondaryColor = Color(0xff018786);

  /// RGB 51, 196, 168
  static const Color scaffoldColor = Color(0xfff8f8f8);
  // static const Color scaffoldColor = Colors.blue;

  static const Color infoHeaderColor = Color.fromRGBO(40, 52, 74, 0.7);


  static const List<Color> gradientColor = [
    secondaryColor,
    mainColor,
  ];

  static const TextStyle buttonTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle sumStyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: Color(0xff018786),
    fontSize: 24
  );
  
  static const TextStyle buttonTextStyleWidthScreen = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 30,
  );

  static const Color mainTextColor = Color(0xff172030);

  static const TextStyle headerAppBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontFamily: 'Horizon',
  );

  /// header textstyle with 18 font size
  static const TextStyle headerTextStyleLess = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: mainColorDark
  );

 static const TextStyle infoTextStyleHeader = TextStyle(
    fontSize: 14,
    color: infoHeaderColor
  );

  static const TextStyle infoTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: mainColorDark
  );


  ///
  /// Inputs
  ///

  static InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: mainColor.withOpacity(0.2)
    )
  );

  static InputBorder inputBorderUnderline = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppStyles.mainColor.withOpacity(0.1)
    )
  );

  static TextStyle inputLabelStyle = TextStyle(
    color: mainColorDark.withOpacity(0.5)
  );

  static TextStyle inputLabelUnderlineStyle = TextStyle(
    fontSize: 18,
    color: AppStyles.mainColorDark.withOpacity(0.6),
  );

  // static TextStyle inputHintStyle = TextStyle(
  //   color: Color(0xff9D9D9F)
  //   // color: Color(0xff383A51)
  // );

  static double inputIconSize = 24;

  static const Color inputIconColor = Color(0xff9D9D9F);



  ///
  /// Buttons
  ///

  
}