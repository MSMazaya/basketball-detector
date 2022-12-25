// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../views/config/config_view.dart';
import '../views/config/lap/lap_view.dart';
import '../views/home/home_view.dart';
import '../views/layout_view.dart';

class Routes {
  static const String layoutView = '/';
  static const String homeView = '/home-view';
  static const String configView = '/config-view';
  static const String lapView = '/lap-view';
  static const all = <String>{
    layoutView,
    homeView,
    configView,
    lapView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.layoutView, page: LayoutView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.configView, page: ConfigView),
    RouteDef(Routes.lapView, page: LapView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LayoutView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LayoutView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    ConfigView: (data) {
      var args = data.getArgs<ConfigViewArguments>(
        orElse: () => ConfigViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ConfigView(key: args.key),
        settings: data,
      );
    },
    LapView: (data) {
      var args = data.getArgs<LapViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LapView(
          key: args.key,
          time: args.time,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ConfigView arguments holder class
class ConfigViewArguments {
  final Key? key;
  ConfigViewArguments({this.key});
}

/// LapView arguments holder class
class LapViewArguments {
  final Key? key;
  final String time;
  LapViewArguments({this.key, required this.time});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {
  Future<dynamic> navigateToLayoutView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.layoutView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToHomeView({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.homeView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToConfigView({
    Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.configView,
      arguments: ConfigViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLapView({
    Key? key,
    required String time,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.lapView,
      arguments: LapViewArguments(key: key, time: time),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
