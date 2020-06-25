# Template for MVI pattern in Flutter

This template written on top [Stacked](https://pub.dev/packages/stacked) library.

## Why this template

Standard pattern for flutter let you code everything in the widget. This approach is easy to learn, but the more you learn you will notice "Separation of Concern (S.o.C)" is not the top priority of the standard pattern. There are a lot of popular pattern in community such as `BLoC`, `MVP`, `MVVM` and `MVI`. Personally i think MVI is the better way, so i wrote this template.

In this template `setState((){...})` is replaced to `render()` and only available on `Action class`. So, just like before, every state change is triggering whole widget re-build, but it can only be accessed from action. The view can't trigger self re-build because it doesn't have state.

Also, action doesn't have access to context, so if it need to do an action which need a `context` it will be injected by a service locator (`get_it` library).

## How to code
To use this pattern, your `StatefulWidget` is should be separated into `State`, `Action`, and `View`.

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
  HomeAction initAction() => HomeAction();

  @override
  Widget staticChildBuilder(BuildContext context) => EmptyScreen();

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
          onPressed: () => action.cancelAndClose(),
        ),
        title: Text(AppString.TITLE_SETTING),
      ),
      body: ListView(
        children: [
          FlatButton(
            child: Text('Add Age'),
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

## How to run

- Just run

```bash
$ flutter run
```

- Build json serializable before run

```bash
$ ./asBuildAndRun.sh
```

- (optional) watch json serializable change while run

```bash
$ ./asWatchJson.sh
```

- (Tips) Just run on specific port (3600)

```bash
$ flutter run --web-port 3600
```

## Library usage

1. [Stacked](https://pub.dev/packages/stacked), for base framework
2. [GetIt](https://pub.dev/packages/get_it), for depedency injection
3. [equatable](https://pub.dev/packages/equatable), for state equality check
4. [flutter_color](https://pub.dev/packages/flutter_color), for color handling
5. [json_annotation](https://pub.dev/packages/json_annotation), for json serializable
6. [intl](https://pub.dev/packages/intl), for internationalization
7. [fluro](https://pub.dev/packages/fluro), for navigation helper
8. [blobs](https://pub.dev/packages/blobs), beautiful blob generator
9. [cached_network_image](https://pub.dev/packages/cached_network_image), handle nertwork image caching
10. [flutter_feather_icons](https://pub.dev/packages/flutter_feather_icons), preset icon
11. [line_awesome_icons](https://pub.dev/packages/line_awesome_icons), preset icon
12. [statusbar](https://pub.dev/packages/statusbar), set status bar color
13. [google_fonts](https://pub.dev/packages/google_fonts), preset font
14. [google_nav_bar](https://pub.dev/packages/google_nav_bar), beautiful bottom nav bar
