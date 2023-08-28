import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.black, circularTrackColor: Colors.black),
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.grey)),
    colorScheme: const ColorScheme.light(
        primary: Colors.black, brightness: Brightness.light));
