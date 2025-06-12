import 'package:flutter/material.dart';

import 'package:currency_converter/presentation.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    late final Widget page;

    switch (routeSettings.name) {
      case homeRoute:
        page = HomePage();
        break;

      default:
        return null;
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, dynamic) {
          if (didPop) {
            return;
          }
        },
        child: page,
      ),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );
  }
}
