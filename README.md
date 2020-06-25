# Template for MVI pattern in Flutter

This template written on top [Stacked](https://pub.dev/packages/stacked) library.

## Why this template

Standard pattern for flutter let you code everything in the widget. This approach is easy to learn, but the more you learn you will notice "Separation of Concern (S.o.C)" is not the top priority of standard pattern. There are lot popular pattern in community such as BLoC, MVP, MVVM and MVI. Personally i think MVI is the better way, so i wrote this template.

In this template `setState(){...}` is replaced to `render()` and only available on `Action class`. So, just like before, every state change is triggering whole widget re-build, but it can only be accessed from action. The view can't trigger self re-build because it doesn't have state.

Also, action doesn't have access to context, so if it need to do an action which need a `context` it will be injected by a service locator (`get_it` library).

## How to code

1. To use this pattern, your `StatefulWidget` is should be separated into `State`, `Action`, and `View`.

```dart
// previously
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  int age = 0;

  void increaseAge() {
    setState(() {
      age += 1;
    });
  }

  void navigateToSetting() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => SettingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FeatherIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppString.TITLE_SETTING),
      ),
      body: ListView(
        children: [
          FlatButton(
            child: Text('Nambah Umur'),
            onPressed: () => increaseAge(),
          ),
          FlatButton(
            child: Text('Navigate to setting'),
            onPressed: () => navigateToSetting(),
          ),
        ],
      ),
    );
  }
}

// after

// ignore: must_be_immutable
class HomeState extends Equatable {
  int age = 0;

  @override
  List<Object> get props => [age];
}

class HomeAction extends BaseAction<HomeScreen, HomeAction, HomeState> {
  @override
  Future<HomeState> initState() async => HomeState();

  void increaseAge() {
    state.age += 1;
    render();
  }

  void navigateToSetting() {
    navigator().navigateTo(SettingScreen());
  }
}

class HomeView extends BaseView<HomeScreen, HomeAction, HomeState> {
  @override
  HomeAction viewModelBuilder(BuildContext context) => HomeAction();

  @override
  Widget staticChildBuilder(BuildContext context) {
    return EmptyScreen(
      'assets/money-bender.png',
      AppString.CAPTION_HOME_SCREEN,
      ['9-6-884'],
    );
  }

  @override
  Widget loadingViewBuilder(BuildContext context) => Container();

  @override
  Widget render(
    BuildContext context,
    HomeAction action,
    HomeState state,
    Widget staticChild,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FeatherIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppString.TITLE_SETTING),
      ),
      body: ListView(
        children: [
          FlatButton(
            child: Text('Nambah Umur'),
            onPressed: () => action.increaseAge(),
          ),
          FlatButton(
            child: Text('Navigate to setting'),
            onPressed: () => action.navigateToSetting(),
          ),
        ],
      ),
    );
  }
}
```

2.

## How to run

1. Just run

```bash
$ flutter run
```

2. Build json serializable before run

```bash
$ ./asBuildAndRun.sh
```

3. (optional) watch json serializable change while run

```bash
$ ./asWatchJson.sh
```

4. (Tips) Just run on specific port (3600)

```bash
$ flutter run --web-port 3600
```

## Library usage

1.
