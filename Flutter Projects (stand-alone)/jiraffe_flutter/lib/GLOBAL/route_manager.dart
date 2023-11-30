import 'package:flutter/material.dart';
import 'package:jiraffe_flutter/product_backlog/product_backlog.dart';

class JiraffeRouteManager {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    
    // final dynamic arguments = settings.arguments;

    switch (settings.name) {
      case ProductBacklogPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const ProductBacklogPage());
      default:
        throw FlutterError("No Path Found... \nPath entered: ${settings.name}");
    }
  }


  


}
