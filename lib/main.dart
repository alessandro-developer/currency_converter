import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:currency_converter/app.dart';
import 'package:currency_converter/business_logic.dart';

void main() async {
  await _initialization();

  Bloc.observer = DebugBloc();

  runApp(App());
}

Future<void> _initialization() async {
  /// SYSTEM SECTION:
  WidgetsFlutterBinding.ensureInitialized();
  for (var renderView in RendererBinding.instance.renderViews) {
    renderView.automaticSystemUiAdjustment = false;
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
