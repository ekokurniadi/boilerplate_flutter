import 'package:flutter/material.dart';

class AppColors {
  // * Primary
  static const Color primary50 = Color(0xFFFFE5E7);
  static const Color primary100 = Color(0xFFFFB2B6);
  static const Color primary200 = Color(0xFFFF8085);
  static const Color primary300 = Color(0xFFFF4D55);
  static const Color primary400 = Color(0xFFFF000C);
  static const Color primary500 = Color(0xFFCC000A);
  static const Color primary600 = Color(0xFF990007);
  static const Color primary700 = Color(0xFF660005);
  static const Color primary800 = Color(0xFF330002);

  // * Secondary
  static const Color secondary50 = Color(0xFFFFEBE5);
  static const Color secondary100 = Color(0xFFFFC4B2);
  static const Color secondary200 = Color(0xFFFF9D80);
  static const Color secondary300 = Color(0xFFFF764D);
  static const Color secondary400 = Color(0xFFFF3D00);
  static const Color secondary500 = Color(0xFFCC3000);
  static const Color secondary600 = Color(0xFF992400);
  static const Color secondary700 = Color(0xFF661800);
  static const Color secondary800 = Color(0xFF330C00);

  // * Neutral
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFE5E5E5);
  static const Color neutral200 = Color(0xFFD9D9D9);
  static const Color neutral300 = Color(0xFFB3B3B3);
  static const Color neutral400 = Color(0xFF797979);
  static const Color neutral500 = Color(0xFF595959);
  static const Color neutral600 = Color(0xFF404040);
  static const Color neutral700 = Color(0xFF2B2B2B);
  static const Color neutral800 = Color(0xFF1A1A1A);

  // * Success
  static const Color success50 = Color(0xFFE5FFEA);
  static const Color success100 = Color(0xFFB2FFBF);
  static const Color success200 = Color(0xFF80FF95);
  static const Color success300 = Color(0xFF4DFF6A);
  static const Color success400 = Color(0xFF00FF2B);
  static const Color success500 = Color(0xFF00CC22);
  static const Color success600 = Color(0xFF00991A);
  static const Color success700 = Color(0xFF006611);
  static const Color success800 = Color(0xFF003309);

  // * Danger
  static const Color danger50 = Color(0xFFFFE5E5);
  static const Color danger100 = Color(0xFFFFB2B2);
  static const Color danger200 = Color(0xFFFF8080);
  static const Color danger300 = Color(0xFFFF4D4D);
  static const Color danger400 = Color(0xFFFF0000);
  static const Color danger500 = Color(0xFFCC0000);
  static const Color danger600 = Color(0xFF990000);
  static const Color danger700 = Color(0xFF660000);
  static const Color danger800 = Color(0xFF330000);

  // * Warning
  static const Color warning50 = Color(0xFFFFFEE5);
  static const Color warning100 = Color(0xFFFFFBB2);
  static const Color warning200 = Color(0xFFFFF980);
  static const Color warning300 = Color(0xFFFFF64D);
  static const Color warning400 = Color(0xFFFFF200);
  static const Color warning500 = Color(0xFFCCC200);
  static const Color warning600 = Color(0xFF999100);
  static const Color warning700 = Color(0xFF666100);
  static const Color warning800 = Color(0xFF333000);

  // * Text
  static const Color text50 = Color(0xFFfdfdfd);
  static const Color text100 = Color(0xFFe8e8e8);
  static const Color text300 = Color(0xFF919191);
  static const Color text500 = Color(0xFF272727);

  // * Background
  static const Color bg100 = Color(0xFFfdfdfd);
  static const Color bg200 = Color(0xFFf1f1f1);
  static const Color bg300 = Color(0xFFf3f3f3);
  static const Color bgFilter = Color(0xFFefefef);

  static const Color gray300 = Color(0xFFf2f2f2);
  static const Color yellow = Color(0xFFFFD700);
  static const Color yellow500 = Color(0xFFF99207);
  static const Color blue = Color(0xFF2BCCE5);

  // * Gradient
  static const primaryGradient = [
    AppColors.primary400,
    AppColors.secondary400,
  ];
  static const softPrimaryGradient = [
    AppColors.primary100,
    AppColors.secondary200,
  ];
  static const neutralGradient = [
    AppColors.neutral300,
    AppColors.neutral400,
  ];
  static const dangerGradient = [
    AppColors.danger500,
    AppColors.danger700,
  ];
}
