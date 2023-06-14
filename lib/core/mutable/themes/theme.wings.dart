import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WingsTheme {
  static Color primaryColor = const Color(0xffEE4260);
  static Color secondaryColor = const Color(0xff231B4A);

  static var primarySwatch = MaterialColor(
    primaryColor.value,
    const {
      50: Color(0xff141336),
      100: Color(0xff2A296E),
      200: Color(0xff3A388E),
      300: Color(0xff6361C4),
      400: Color(0xff7A77E8),
      500: Color(0xffEE4260),
      600: Color(0xffAEACF2),
      700: Color(0xffCDCCF9),
      800: Color(0xff1E293B),
      900: Color(0xffecebfc),
    },
  );

  static var secondarySwatch = MaterialColor(
    const Color(0xff818E9B).value,
    const {
      50: Color(0xff14191E),
      100: Color(0xff2E3842),
      200: Color(0xff424F5C),
      300: Color(0xff52606E),
      400: Color(0xff818E9B),
      500: Color(0xff231B4A),
      600: Color(0xffCDD8E3),
      700: Color(0xffDDE5ED),
      800: Color(0xffF2F5F7),
      900: Color(0xffecebfc),
    },
  );

  static bool get bigScreen => 1.sh > 800;

  static Color get greyedOut => Colors.grey;

  static Color get greyedOutLight => Colors.grey.withOpacity(0.2);

  static Color buttonColor(Set<MaterialState> states, Color color) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return color.withOpacity(.9);
    }
    return color;
  }

  static Color containerBackgroundColor = const Color(0xffF1F5F9);

  static Color primaryColorDark = const Color(0xff181461);

  static Color scaffoldBackgroundColor = const Color(0xffF9FAFC);
  static Color inputBackgroundColor = const Color(0xffE2E8F0);

  static Color shadowColor = const Color(0xff062761).withOpacity(0.1);
  static Color strongShadowColor = const Color(0xff062761).withOpacity(0.2);
  static Color warningDarkColor = const Color(0xffFDAE1B);
  static Color warningLightColor = const Color(0xffFFF0E7);

  static Color successDarkColor = const Color(0xff39CC60);
  static Color successLightColor = const Color(0xffE2FFEA);

  static Color blueDarkColor = const Color(0xff397ecc);
  static Color blueLightColor = const Color(0xffe2f1ff);

  static Color dangerDarkColor = const Color(0xffFF434F);
  static Color dangerLightColor = const Color(0xffFEE8E9);

  static String fontFamily = 'Arabic';

  static Color textColor = const Color(0xff3D564D);
  static Color secondTextColor = const Color(0xff64748B);

  static TextStyle heading = TextStyle(
    fontSize: 20.sp,
    height: 1.3,
    color: textColor,
    fontFamily: fontFamily,
  );

  static TextStyle heading500 = TextStyle(
    fontSize: 24.sp,
    height: 1.3,
    color: textColor,
    fontFamily: fontFamily,
  );

  static TextStyle bigHeading = TextStyle(
    fontSize: 32.sp,
    height: 1.3,
    color: textColor,
    fontFamily: fontFamily,
  );

  static get bigHeading600 => bigHeading.copyWith(fontWeight: FontWeight.w600);

  static TextStyle body1 = TextStyle(
    fontSize: 16.sp,
    height: 1.4,
    color: textColor,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400
  );
  static TextStyle body1Point5 = TextStyle(
    fontSize: 18.sp,
    height: 1.5,
    color: textColor,
    fontFamily: fontFamily,
  );
  static TextStyle body2 = TextStyle(
    fontSize: 14.sp,
    height: 1.5,
    color: textColor,
    fontFamily: fontFamily,
  );
  static TextStyle body3 = TextStyle(
    fontSize: 12.sp,
    height: 1.6,
    color: textColor,
    fontFamily: fontFamily,
  );
  static TextStyle body4 = TextStyle(
    fontSize: 10.sp,
    height: 1.6,
    color: textColor,
    fontFamily: fontFamily,
  );

  static get body1600 => body1.copyWith(fontWeight: FontWeight.w600);

  static EdgeInsets pagePadding =
      EdgeInsets.only(top: 0.075.sh, left: 0.05.sw, right: 0.05.sw);

  // the horizontal padding of the app
  static double padding = 16;
  static EdgeInsets appPadding = EdgeInsets.symmetric(horizontal: padding);

  static BorderRadius borderRadius = BorderRadius.circular(10);
  static BorderRadius defaultRadius = BorderRadius.circular(0.02.sh);
  static BorderRadius inputRadius = BorderRadius.circular(0.02.sh);
  static BorderRadius fullRadius = BorderRadius.circular(100);

  static List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: shadowColor,
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, 1)
    ),
  ];

  static Divider defaultDivider =
      Divider(color: WingsTheme.secondTextColor, height: 0, thickness: 1);

  static double get squircleButtonRadius => 0.015;
}

/// The 2018 spec has thirteen text styles:
/// ```
/// NAME         SIZE  WEIGHT  SPACING
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
