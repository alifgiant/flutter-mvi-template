import 'package:aset_ku/core/resources/res_color.dart';
import 'package:aset_ku/core/utils/debouncer.dart';
import 'package:aset_ku/feature/playground/feature_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EasterEgg {
  static const String password = "this is template passwor";
  static const int maxClicked = 7;

  Debouncer debugScreenDebouncer = Debouncer();

  String typedPassword = '';
  int clicked = 0;

  void scheduleCancelClick() async {
    debugScreenDebouncer.runAtEnd(() {
      clicked = 0;
    });
  }

  void onClick() {
    scheduleCancelClick();

    clicked += 1;
    if (clicked >= maxClicked) {
      Get.dialog(Dialog(
        child: Wrap(
          children: [
            Container(
              child: Text(
                'Easter Egg',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(12),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                onChanged: (str) => typedPassword = str,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              child: FlatButton(
                child: Text('Open'),
                color: ResColor.darkBlue,
                textColor: Colors.white,
                onPressed: () {
                  if (typedPassword == password) {
                    Get.back();
                    Get.to(FeatureCheckScreen());
                  }
                },
              ),
            )
          ],
        ),
      ));
    }
  }
}
