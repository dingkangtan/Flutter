import 'package:flutter/material.dart';

class ConstantUtils {
  // Font family
  static const fontRoboto = "Roboto";
  static const fontRaleway = "Raleway";
  static const fontDancingScript = "DancingScript";
  static const fontCaveatBrush = "CaveatBrush";

  // Font Size
  static const extraLargeFontSize = 24.0;
  static const largeFontSize = 18.0;
  static const commonFontSize = 16.0;
  static const normalFontSize = 14.0;
  static const smallFontSize = 12.0;

  // Padding
  static const extraLargePadding = 24.0;
  static const largePadding = 18.0;
  static const commonPadding = 16.0;
  static const normalPadding = 14.0;
  static const smallPadding = 12.0;
  static const extraSmallPadding = 8.0;

  // Margin
  static const extraLargeMargin = 24.0;
  static const largeMargin = 18.0;
  static const commonMargin = 16.0;
  static const normalMargin = 14.0;
  static const smallMargin = 12.0;
  static const extraSmallMargin = 6.0;

  // Name size
  static const TextStyle nameTextStyle = TextStyle(
    fontSize: 24.0,
  );

  // Font Style
  static const TextStyle largeTextStyle = TextStyle(
    fontSize: 18.0,
  );
  static const TextStyle commonTextStyle = TextStyle(
    fontSize: 16.0,
  );
  static const TextStyle normalTextStyle = TextStyle(
    fontSize: 14.0,
  );
  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 12.0,
  );

  static Container buildDividerContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade200,
    );
  }

  static TextStyle labelStyle = TextStyle(
    fontSize: 20.0,
  );

  static TextStyle hintStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.grey,
  );

  static TextStyle normalStyle = TextStyle(
    fontSize: 18.0,
  );

  static TextStyle buttonStyle = TextStyle(fontSize: 18, color: Colors.white);
}
