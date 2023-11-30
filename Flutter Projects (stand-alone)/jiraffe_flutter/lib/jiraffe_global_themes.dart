import 'package:flutter/material.dart';

class JiraffeThemes {
  static const Color mainBackgroundColor = Color.fromRGBO(228, 160, 183, 1.0);

  static const Color mainBackgroundColor2 = Color.fromARGB(255, 246, 208, 221);

  static const Color sideBarBackgroundColor = Color.fromRGBO(232, 181, 190, 1);

  static const Color sideBarItemHoverColor = Color.fromRGBO(97, 97, 97, 0.6);
  static const Color sideBarItemSelectColor = Color.fromRGBO(223, 195, 200, 1);
  static const Color sideBarItemSelectBorderColor =
      Color.fromRGBO(223, 195, 200, 1);

  static const Color low = Color(0xff0D9F00);  // Color( int.parse("0xff" + "0D9F00") );
  static const Color medium = Color(0xffE7D000);
  static const Color important = Color(0xffFF6B00);
  static const Color urgent = Color(0xffFF0000);

  static Image deleteIconImg = Image.asset(
    'assets/icons/delete_96x96.png',
    fit: BoxFit.contain,
    width: 35,
    height: 35,
  );

  static Image productBacklogHeaderImg = Image.asset(
    'assets/icons/title_product_backlog.png',
    fit: BoxFit.contain,
    width: 510,
    height: 70,
    alignment: Alignment.centerLeft,
  );

  static Image jiraffeLogoHeaderImg = Image.asset(
    'assets/icons/brand_logo_1.png',
    fit: BoxFit.fitHeight,
    scale: 0.5,
    height: 50,
  );
  static Image jiraffeLogoSideBarImg = Image.asset(
    'assets/icons/brand_logo_1.png',
    fit: BoxFit.contain,
    width: 150,
    height: 60,
  );

  static ThemeData appThemeData = ThemeData(useMaterial3: true);

  static Image jiraffeProductBacklogIcon = Image.asset(
    'assets/icons/product_backlog_1_64x64.png',
    fit: BoxFit.contain,
    height: 40,
    width: 40,
  );

  static Image jiraffeSprintsIcon = Image.asset(
    'assets/icons/sprint_1_80x80.png',
    fit: BoxFit.contain,
    height: 40,
    width: 40,
  );

  static Image jiraffeSprintBoardIcon = Image.asset(
    'assets/icons/sprint_board_2_100x100.png',
    fit: BoxFit.contain,
    height: 40,
    width: 40,
  );

  static Image jiraffeAdminViewIcon = Image.asset(
    'assets/icons/admin_100x100.png',
    fit: BoxFit.contain,
    height: 40,
    width: 40,
  );
}
