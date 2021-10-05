import 'package:flutter/material.dart';

// Flutter hex color is an external package for converting colors starting with #
// to 0xFFFFFF format.
// You need to add it to your pubspec.yaml file.
import 'package:flutter_hex_color/flutter_hex_color.dart';

// google fonts is an external package. you need to add it to your pubspec.yaml file
import 'package:google_fonts/google_fonts.dart';

class NoSignalTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        //  Will Work on LightTheme in later Future
        // Initally when thought about creating this app, I only thought about dark theme.
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navyblueshade2,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        iconTheme: IconThemeData(color: Colors.white),
        // ignore: deprecated_member_use
        accentColor: navyblueshade3,
        appBarTheme: AppBarTheme(
          backgroundColor: navyblueshade2,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: navyblueshade4,
        ),
      );

  //  Color Codes for Dark Theme
  static Color navyblueshade1 = HexColor('#1C223A');
  static Color navyblueshade2 = HexColor('#1E233E');
  static Color navyblueshade3 = HexColor('#161A2C');
  static Color navyblueshade4 = HexColor('#20263F');
  static Color whiteShade1 = HexColor('#C7D8EB');
  static Color lightBlueShade = HexColor('#87A5B9');
}
