import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_start_conversation/screens/fastWhatsapp/fast_whatsapp.dart';
import 'package:whatsapp_start_conversation/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _isPortuguese = Platform.localeName == 'pt_BR';
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    _updateNavigationBarColor(SchedulerBinding.instance.window.platformBrightness == Brightness.dark);
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  _updateNavigationBarColor(bool darkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: darkMode ? Colors.grey[850] : Colors.white,
        systemNavigationBarIconBrightness: darkMode ? Brightness.light : Brightness.dark
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    _updateNavigationBarColor(SchedulerBinding.instance.window.platformBrightness == Brightness.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast WhatsApp',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: FastWhatsapp(
        isPortuguese: _isPortuguese
      )
    );
  }
}