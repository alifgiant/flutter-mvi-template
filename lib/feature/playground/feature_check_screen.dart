import 'package:aset_ku/core/framework/base_action.dart';
import 'package:aset_ku/core/framework/base_view.dart';
import 'package:aset_ku/core/storage/app_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class FeatureCheckState extends Equatable {
  var isDummyOn = AppConfig.isDummyOn;
  @override
  List<Object> get props => [];
}

class FeatureCheckAction extends BaseAction<FeatureCheckScreen,
    FeatureCheckAction, FeatureCheckState> {
  @override
  Future<FeatureCheckState> initState() async => FeatureCheckState();

  void updateDummyModeValue(bool value) {
    state.isDummyOn.val = value;
    render();
  }
}

class FeatureCheckScreen extends BaseView<FeatureCheckScreen,
    FeatureCheckAction, FeatureCheckState> {
  @override
  FeatureCheckAction initAction() => FeatureCheckAction();

  @override
  Widget loadingViewBuilder(BuildContext context) => Container();

  @override
  Widget render(
    BuildContext context,
    FeatureCheckAction action,
    FeatureCheckState state,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () => action.closeScreen(),
        ),
        title: Text('Feature Check Screen'),
        elevation: 2,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('assets/cat-book.png', height: 250),
          getButtons(action, state),
        ],
      ),
    );
  }

  ListView getButtons(FeatureCheckAction action, FeatureCheckState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
      children: [
        createToggles(action, state),
        Container(height: 21),
        createActions(action, state),
      ],
    );
  }

  Widget createActions(FeatureCheckAction action, FeatureCheckState state) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Text(
          'Single Actions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(height: 12),
        actionButton('snack bar neutral', () {
          action.showSnackBar(
            title: 'This is a title',
            message: 'This is a longer content message',
          );
        }),
        actionButton('snack bar red', () {
          action.showSnackBar(
            title: 'This is a title',
            message: 'This is a longer content message',
            type: SnackBarType.RED,
          );
        }),
        actionButton('snack bar yellow', () {
          action.showSnackBar(
            title: 'This is a title',
            message: 'This is a longer content message',
            type: SnackBarType.YELLOW,
          );
        }),
        actionButton('snack bar green', () {
          action.showSnackBar(
            title: 'This is a title',
            message: 'This is a longer content message',
            type: SnackBarType.GREEN,
          );
        }),
        actionButton('bottom sheet option', () {
          action.showSheet(List.generate(
            20,
            (i) => FlatButton(
              child: Text('opsi - ${i + 1}'),
              onPressed: () {
                Get.back();
                action.showSnackBar(message: 'opsi - ${i + 1}');
              },
            ),
          ));
        }),
      ],
    );
  }

  RaisedButton actionButton(String title, VoidCallback callBack) {
    return RaisedButton(child: Text(title), onPressed: callBack);
  }

  Column createToggles(FeatureCheckAction action, FeatureCheckState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Toggles',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(height: 12),
        SwitchListTile(
          title: Text('Is Dummy Mode'),
          subtitle: Text('All api/db transacation is mocked when turned on'),
          value: state.isDummyOn.val,
          onChanged: (value) => action.updateDummyModeValue(value),
        ),
      ],
    );
  }
}
