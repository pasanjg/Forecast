//import 'package:flutter/material.dart';
//import 'current_weather_bloc.dart';
//export 'current_weather_bloc.dart';
//
//class CurrentWeatherBlocProvider extends InheritedWidget {
//  final CurrentWeatherBloc bloc;
//
//  CurrentWeatherBlocProvider({Key key, Widget child})
//      : bloc = CurrentWeatherBloc(),
//        super(key: key, child: child);
//
//  @override
//  bool updateShouldNotify(_) {
//    return true;
//  }
//
////  static CurrentWeatherBloc of(BuildContext context) {
////    return ((CurrentWeatherBlocProvider) as CurrentWeatherBlocProvider).bloc;
////  }
//
//  static CurrentWeatherBloc of(BuildContext context) {
//    return (context.inheritFromWidgetOfExactType(CurrentWeatherBlocProvider)
//            as CurrentWeatherBlocProvider)
//        .bloc;
//  }
//}
