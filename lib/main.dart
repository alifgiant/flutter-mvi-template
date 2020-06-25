import 'package:aset_ku/core/framework/navigation_service.dart';
import 'package:aset_ku/core/framework/service_locator.dart';
import 'package:aset_ku/core/resources/app_color.dart';
import 'package:aset_ku/core/resources/app_text_style.dart';
import 'package:aset_ku/core/utils/money_utils.dart' as MoneyUtils;
import 'package:aset_ku/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:statusbar/statusbar.dart';

void main() {
  MoneyUtils.registerMoneyType();
  GetIt.instance.setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatusBar.color(AppColor.darkBlue);
    return MaterialApp(
      title: 'Aset Ku',
      theme: getAppLightTheme(),
      navigatorKey: GetIt.I.get<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false, // TODO: remove banner
      home: HomeScreen(),
    );
  }

  ThemeData getAppLightTheme() {
    return ThemeData(
      primaryColor: AppColor.darkBlue,
      primaryColorDark: AppColor.darkBlue,
      appBarTheme: getAppBarTheme(),
      accentColor: AppColor.darkOrange,
      scaffoldBackgroundColor: AppColor.lightGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  AppBarTheme getAppBarTheme() {
    return AppBarTheme(
      color: AppColor.lightGrey,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.darkBlue),
      textTheme: TextTheme(headline6: AppTextStyle.appBarTitle),
    );
  }
}
