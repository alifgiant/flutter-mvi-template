import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

typedef IconFactory = Widget Function();

class ResIcon {
  static Map<String, IconFactory> _icons = {
    'default': () => Icon(FeatherIcons.x),
    'home': () => Icon(FeatherIcons.home),
    'setting': () => Icon(FeatherIcons.settings),
    'add': () => Icon(FeatherIcons.plus),
    'cash': () => Icon(LineAwesomeIcons.wallet),
    'bank': () => Icon(LineAwesomeIcons.landmark),
    'forex': () => Icon(LineAwesomeIcons.globe),
    'deposit': () => Icon(LineAwesomeIcons.piggy_bank),
    'insurance': () => Icon(LineAwesomeIcons.medkit),
    'rareMetal': () => Icon(LineAwesomeIcons.gem),
    'stock': () => Icon(LineAwesomeIcons.chart_line),
    'mutFund': () => Icon(LineAwesomeIcons.handshake),
    'bond': () => Icon(FeatherIcons.pocket),
    'estate': () => Icon(LineAwesomeIcons.home),
  };

  static Widget getIcon(String name) {
    if (name == null) return null;
    if (name.isNotEmpty && _icons.containsKey(name)) return _icons[name].call();
    return _icons['defaults'].call();
  }
}
