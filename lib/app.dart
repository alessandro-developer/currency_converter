import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:currency_converter/presentation.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppRoute appRouter = AppRoute();
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
    builder: (context, child) => ResponsiveBreakpoints.builder(
      child: Builder(
        builder: (context) => ResponsiveScaledBox(
          width: ResponsiveValue<double?>(
            context,
            conditionalValues: <Condition<double?>>[
              const Condition.equals(name: MOBILE, value: 450),
            ],
          ).value,
          child: LoaderOverlay(
            overlayColor: ColorPalette.black.withValues(alpha: 0.2),
            overlayWidgetBuilder: (_) => Center(
              child: CircularProgressIndicator(color: ColorPalette.greenLight),
            ),
            child: child!,
          ),
        ),
      ),
      breakpoints: _breakpoints,
    ),
    initialRoute: homeRoute,
    navigatorKey: navKey,
    onGenerateRoute: appRouter.onGenerateRoute,
    title: 'Currency Converter',
  );
}

final List<Breakpoint> _breakpoints = <Breakpoint>[
  const Breakpoint(start: 0, end: 450, name: MOBILE),
  const Breakpoint(start: 451, end: 750, name: 'SMALL_TABLET'),
  const Breakpoint(start: 751, end: 1030, name: TABLET),
  const Breakpoint(start: 1031, end: double.infinity, name: DESKTOP),
];
