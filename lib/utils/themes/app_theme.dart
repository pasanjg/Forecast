import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forecast/utils/themes/themes.dart';

/// Code referred from a Medium post.
/// See <https://medium.com/flutter-community/dynamic-theming-with-flutter-78681285d85f> for source.

class _AppTheme extends InheritedWidget {
  final AppThemeState data;

  _AppTheme({
    this.data,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppTheme oldWidget) {
    return true;
  }
}

class AppTheme extends StatefulWidget {
  final Widget child;

  const AppTheme({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  AppThemeState createState() => new AppThemeState();

  static ThemeData of(BuildContext context) {
    _AppTheme inherited =
        (context.dependOnInheritedWidgetOfExactType<_AppTheme>());
    return inherited.data.theme;
  }

  static AppThemeState instanceOf(BuildContext context) {
    _AppTheme inherited =
        (context.dependOnInheritedWidgetOfExactType<_AppTheme>());
    return inherited.data;
  }
}

class AppThemeState extends State<AppTheme> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  void initState() {
    super.initState();
  }

  void changeTheme(AppThemeKeys themeKey) {
    setState(() {
      _theme = AppThemes.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _AppTheme(
      data: this,
      child: widget.child,
    );
  }
}
