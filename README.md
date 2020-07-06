# Template for MVI pattern in Flutter

This template written on top [Get](https://pub.dev/packages/get) library.

## Why this template

Standard pattern for flutter let you code everything in the widget. This approach is easy to learn, but the more you learn you will notice "Separation of Concern (S.o.C)" is not the top priority of the standard pattern. There are a lot of popular pattern in community such as `BLoC`, `MVP`, `MVVM` and `MVI`. Personally i think MVI is the better way, so i wrote this template.

In this template `setState((){...})` is replaced to `render()` and only available on `Action class`. So, just like before, every state change is triggering whole widget re-build, but it can only be accessed from action. The view can't trigger self re-build because it doesn't direct reference to action nor state.

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
    Get.to(SettingScreen());
  }
}

class HomeScreen extends BaseView<HomeScreen, HomeAction, HomeState> {
  @override
  HomeAction initAction() => HomeAction();

  @override
  Widget loadingViewBuilder(BuildContext context) => Container();

  @override
  Widget render(
    BuildContext context,
    HomeAction action,
    HomeState state
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
          FlatButton(
            child: Text('Reload screen'),
            onPressed: () => action.reloadScreen(),
          ),
        ],
      ),
    );
  }
}
```

see more [example](lib/feature/playground/feature_check_screen.dart)

2. Every screen is a loadable ready screen. As you can see on above `action` example, initState is a `future` function which you can use to retrive data from a source. So, in the meantime the screen will load view from `loadingViewBuilder`. You can load a spinner or shimmer on it.

3. `action.reloadScreen()` will retrigger `onReady` future and reset isBusy flag.

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

## Other interesting things

- This template has set app icon and app splash screen both on android and ios. So all you need to do is replace exisitng images.
- Material Icon is disabled by default, because prefer to use custom icon.

## Unfinished template

- [ ] Internationalization template
- [ ] Image sourcing template
- [ ] Usecase - Repository pattern
- [ ] Unit test example

## Library usage

1. [get](https://pub.dev/packages/get), for micro framework.
2. [get_storage](https://pub.dev/packages/get_storage), for fast storage solution.
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
