import 'package:aset_ku/core/framework/base_action.dart';
import 'package:aset_ku/core/framework/base_view.dart';
import 'package:aset_ku/core/model/Example.dart';
import 'package:aset_ku/core/resources/res_strings.dart';
import 'package:aset_ku/core/view/empty_screen.dart';
import 'package:aset_ku/feature/playground/feature_check_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeState extends Equatable {
  List<Example> example;

  HomeState({
    this.example = const [],
  });

  @override
  List<Object> get props => [example];
}

class HomeAction extends BaseAction<HomeScreen, HomeAction, HomeState> {
  @override
  Future<HomeState> initState() async => HomeState();

  void goToPlayground() {
    Get.to(FeatureCheckScreen());
  }
}

class HomeScreen extends BaseView<HomeScreen, HomeAction, HomeState> {
  @override
  HomeAction initAction() => HomeAction();

  Widget createEmpty() {
    return EmptyScreen(
      'assets/money-bender.png',
      ResString.CAPTION_HOME_SCREEN,
      ['9-6-884'],
    );
  }

  @override
  Widget loadingViewBuilder(BuildContext context) => Container();

  @override
  Widget render(BuildContext context, HomeAction action, HomeState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ResString.TITLE_APP),
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.settings),
            onPressed: () => action.goToPlayground(),
          ),
        ],
      ),
      body: state.example.isEmpty ? createEmpty() : createBody(context, action),
      floatingActionButton: FloatingActionButton(
        child: Icon(FeatherIcons.plus),
        heroTag: "homeAdd",
        onPressed: () {},
      ),
    );
  }

  Widget createBody(BuildContext context, HomeAction action) {
    return ListView(
      children: [],
    );
  }
}
