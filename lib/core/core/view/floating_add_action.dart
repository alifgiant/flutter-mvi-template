import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FloatingAddAction extends StatelessWidget {
  static const BottomPadding = 65.0;
  static const BottomContentPadding = BottomPadding + 56;

  final VoidCallback onPressed;
  final String heroTag;
  const FloatingAddAction({
    Key key,
    this.heroTag,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: BottomPadding),
        child: FloatingActionButton(
          child: Icon(FeatherIcons.plus),
          heroTag: heroTag ?? Get.find<Uuid>().v4(),
          onPressed: () => onPressed.call(),
        ),
      ),
    );
  }
}
