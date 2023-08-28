import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white, circularTrackColor: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.white)),
    colorScheme: const ColorScheme.dark(
        primary: Colors.white, brightness: Brightness.dark));
