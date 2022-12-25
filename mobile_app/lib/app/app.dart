import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/views/config/config_view.dart';
import 'package:mobile_app/views/config/lap/lap_view.dart';
import 'package:mobile_app/views/fields/fields_view.dart';
import 'package:mobile_app/views/home/home_view.dart';
import 'package:mobile_app/views/layout_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LayoutView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ConfigView),
    MaterialRoute(page: LapView),
  ],
  dependencies: [
    Singleton(classType: DialogService),
    LazySingleton(classType: FirestoreService),
    LazySingleton(classType: NavigationService),
  ],
)
class App {}
