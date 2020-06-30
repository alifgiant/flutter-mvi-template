import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SingleOption extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onSelected;

  const SingleOption(
    this.text, {
    @required this.onSelected,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width / 4;
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment:
            (icon != null) ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          if (icon != null) Container(width: padding),
          if (icon != null) icon,
          if (icon != null) Container(width: padding / 3),
          Text(text),
        ],
      ),
      onPressed: onSelected,
    );
  }
}
