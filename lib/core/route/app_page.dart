import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vending_machine/common/c_text.dart';
import 'package:vending_machine/core/route/app_route.dart';
import 'package:vending_machine/screens/filling/filling_screen.dart';
import 'package:vending_machine/screens/home/home_screen.dart';
import 'package:vending_machine/screens/statistics/statistics_sceen.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> args = {};
    if (settings.arguments != null) {
      args = settings.arguments as Map<String, dynamic>;
    }
    Widget route = Scaffold(
      body: Center(
          child: CText(
        text: 'No route defined for ${settings.name}',
      )),
    );

    //PARTICIPATION
    switch (settings.name) {
      case AppRoutes.HOME:
        route = const HomeScreen();
        break;
      case AppRoutes.STATISTIC:
        route = const StatisticsScreen();
        break;
      case AppRoutes.FILLING:
        route = const FillingScreen();
        break;
    }

    return PageTransition(
        child: route,
        type: PageTransitionType.theme,
        settings: RouteSettings(name: settings.name));
  }
}
