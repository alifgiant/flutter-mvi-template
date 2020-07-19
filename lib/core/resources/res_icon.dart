import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

typedef IconFactory = IconData Function();

class ResIcon {
  @visibleForTesting
  static Map<String, IconFactory> icons = {
    // common
    'defaults': () => LineAwesomeIcons.times,
    'home': () => LineAwesomeIcons.home,
    'setting': () => LineAwesomeIcons.tools,
    'add': () => LineAwesomeIcons.plus,

    // asset category
    'cash': () => LineAwesomeIcons.wallet,
    'bank': () => LineAwesomeIcons.landmark,
    'forex': () => LineAwesomeIcons.globe,
    'deposit': () => LineAwesomeIcons.piggy_bank,
    'insurance': () => LineAwesomeIcons.medkit,
    'rareMetal': () => LineAwesomeIcons.gem,
    'stock': () => LineAwesomeIcons.chart_line,
    'mutFund': () => LineAwesomeIcons.handshake,
    'bond': () => LineAwesomeIcons.get_pocket,
    'estate': () => LineAwesomeIcons.landmark,

    // transaction category
    'cat-food': () => LineAwesomeIcons.utensils,
    'cat-edu': () => LineAwesomeIcons.graduation_cap,
    'cat-health': () => LineAwesomeIcons.stethoscope,
    'cat-hobby': () => LineAwesomeIcons.gamepad,
    'cat-sport': () => LineAwesomeIcons.futbol,
    'cat-charity': () => LineAwesomeIcons.ribbon,
    'cat-fee': () => LineAwesomeIcons.tag,
    'cat-invest': () => LineAwesomeIcons.chart_area,
    'cat-lover': () => LineAwesomeIcons.kiss,
    'cat-gadget': () => LineAwesomeIcons.tv,
    'cat-salary': () => LineAwesomeIcons.briefcase,
    'cat-selling': () => LineAwesomeIcons.shopping_bag,
    'cat-gift': () => LineAwesomeIcons.gift,
    'cat-interest': () => LineAwesomeIcons.percent,
  };

  static IconData get(String name) {
    if (name == null) return null;
    if (name.isNotEmpty && icons.containsKey(name)) return icons[name].call();
    return icons['defaults'].call();
  }

  static Icon ico(
    String name, {
    double size,
    Color color,
    String semanticLabel,
    TextDirection textDirection,
  }) {
    if (name == null) return null;
    return Icon(
      get(name),
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}
