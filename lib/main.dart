import 'package:aset_ku/core/resources/res_color.dart';
import 'package:aset_ku/core/resources/res_text_style.dart';
import 'package:aset_ku/core/storage/app_config.dart';
import 'package:aset_ku/core/utils/service/framework_service_locator.dart';
import 'package:aset_ku/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';

void main({
  FrameworkServiceLocator frSl = const FrameworkServiceLocator(),
  AppConfig appConfig = const AppConfig(),
  Widget root = const MyApp(),
}) async {
  // DI Setup
  frSl.setupFrameworkLocator(Get);

  // config initilizer
  await appConfig.setup();

  runApp(root);
}

class MyApp extends StatelessWidget {
  const MyApp();

  void setupStatusBar() {
    FlutterStatusbarcolor.setStatusBarColor(ResColor.darkBlue);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  Widget build(BuildContext context) {
    setupStatusBar();
    return GetMaterialApp(
      title: 'Aset Ku',
      theme: getAppLightTheme(),
      debugShowCheckedModeBanner: false, // TODO: remove banner
      home: HomeScreen(),
    );
  }

  ThemeData getAppLightTheme() {
    return ThemeData(
      primaryColor: ResColor.darkBlue,
      primaryColorDark: ResColor.darkBlue,
      appBarTheme: getAppBarTheme(),
      accentColor: ResColor.darkOrange,
      scaffoldBackgroundColor: ResColor.lightGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  AppBarTheme getAppBarTheme() {
    return AppBarTheme(
      color: ResColor.lightGrey,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ResColor.darkBlue),
      textTheme: TextTheme(headline6: ResTextStyle.appBarTitle),
    );
  }
}
