import 'package:flutter/cupertino.dart';
import 'package:mobile_app/views/config/config_view.dart';
import 'package:mobile_app/views/fields/fields_view.dart';
import 'package:mobile_app/views/home/home_view.dart';
import 'package:stacked/stacked.dart';

class LayoutViewModel extends BaseViewModel {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  bool _reverse = false;
  bool get reverse => _reverse;

  void setTabIndex(int value) {
    if (value < _currentTabIndex) {
      _reverse = true;
    }
    _currentTabIndex = value;
    notifyListeners();
  }

  final Map<int, Widget> _viewCache = Map<int, Widget>();

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = FieldView();
          break;
        case 1:
          _viewCache[index] = HomeView();
          break;
        case 2:
          _viewCache[index] = ConfigView();
          break;
      }
    }

    return _viewCache[index]!;
  }
}
