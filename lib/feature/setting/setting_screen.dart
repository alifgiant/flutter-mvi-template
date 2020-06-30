import 'package:aset_ku/core/resources/res_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FeatherIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(ResString.TITLE_SETTING),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
