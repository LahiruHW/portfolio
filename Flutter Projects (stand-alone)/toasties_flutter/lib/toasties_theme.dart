import 'package:flutter/material.dart';

/// Stores the theme data for the LegalEase app (both light and dark)
class ToastiesAppTheme {
  ToastiesAppTheme._(); // ._ removes instantiation capability - this class is just a container for the theme data

  static Color blue1 = const Color.fromRGBO(0, 109, 170, 1.0);
  static Color blue2 = const Color.fromRGBO(3, 83, 164, 1.0);
  static Color blue3 = const Color.fromRGBO(6, 26, 64, 1.0);
  static Color blue4 = const Color.fromRGBO(185, 214, 242, 1.0);
  static Color grey1 = const Color.fromRGBO(189, 189, 189, 1.0);
  static Color grey2 = const Color.fromRGBO(103, 103, 103, 1.0);

  static ColorScheme lightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: blue2,
    backgroundColor: blue4,
    errorColor: Colors.red,
    brightness: Brightness.light,
  );

  static ColorScheme darkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: blue2,
    backgroundColor: blue3,
    cardColor: blue3,
    errorColor: Colors.red,
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: blue2.withOpacity(0.6),
      titleTextStyle: ToastiesTextTheme.logoStyle.copyWith(
        color: Colors.white,
        fontSize: 30,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: ToastiesTextTheme.globalTextTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: blue3,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      enableFeedback: true,
      elevation: 0,
    ),
    navigationDrawerTheme: const NavigationDrawerThemeData(
      elevation: 10.0,
      backgroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(blue2),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(15),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: blue1,
      titleTextStyle: ToastiesTextTheme.logoStyle.copyWith(
        color: Colors.white,
        fontSize: 30,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: ToastiesTextTheme.globalTextTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: blue2,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      enableFeedback: true,
      elevation: 0,
    ),
    navigationDrawerTheme: const NavigationDrawerThemeData(
      elevation: 10.0,
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(blue2),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(15),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    useMaterial3: true,
  );
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

class ToastiesTextTheme {
  ToastiesTextTheme._();

  static const TextStyle logoStyle = TextStyle(
    fontFamily: 'Julius Sans One',
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Sulphur Point',
    fontSize: 26,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Overlock',
    fontSize: 22,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle labelStyle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static TextTheme globalTextTheme = TextTheme(
    headlineLarge: ToastiesTextTheme.headingStyle.copyWith(fontSize: 30),
    headlineMedium: ToastiesTextTheme.headingStyle.copyWith(fontSize: 26),
    headlineSmall: ToastiesTextTheme.headingStyle.copyWith(fontSize: 22),
    ///////////////////////////////////////////////////////////////////////
    displayLarge: ToastiesTextTheme.headingStyle.copyWith(fontSize: 30),
    displayMedium: ToastiesTextTheme.headingStyle.copyWith(fontSize: 26),
    displaySmall: ToastiesTextTheme.headingStyle.copyWith(fontSize: 22),
    ///////////////////////////////////////////////////////////////////////
    bodyLarge: ToastiesTextTheme.bodyStyle.copyWith(fontSize: 20),
    bodyMedium: ToastiesTextTheme.bodyStyle.copyWith(fontSize: 18),
    bodySmall: ToastiesTextTheme.bodyStyle.copyWith(fontSize: 16),
    ///////////////////////////////////////////////////////////////////////
    titleLarge: ToastiesTextTheme.logoStyle.copyWith(fontSize: 30),
    titleMedium: ToastiesTextTheme.logoStyle.copyWith(fontSize: 26),
    titleSmall: ToastiesTextTheme.logoStyle.copyWith(fontSize: 22),
    ///////////////////////////////////////////////////////////////////////
    labelLarge: ToastiesTextTheme.labelStyle.copyWith(fontSize: 20),
    labelMedium: ToastiesTextTheme.labelStyle.copyWith(fontSize: 18),
    labelSmall: ToastiesTextTheme.labelStyle.copyWith(fontSize: 16),
  );
}
