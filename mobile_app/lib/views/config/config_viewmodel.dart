import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/app/app.locator.dart';
import 'package:mobile_app/app/app.router.dart';
import 'package:mobile_app/datamodels/lap/lap.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:mobile_app/views/config/config_view.dart';
import 'package:stacked/stacked.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfigViewModel extends BaseViewModel {
  final _pointService = locator<FirestoreService>().pointsCollectionReference;
  final _lapService = locator<FirestoreService>().lapCollection;
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  List<Point> points = [];
  Map<int, String?> valueMap = {};

  void updateAngle() {
    _pointService.get().then((QuerySnapshot<Point> snapshot) {
      snapshot.docs.forEach((DocumentSnapshot<Point> document) async {
        final data = document.data();
        if (valueMap.containsKey(data!.position)) {
          final angle = valueMap[data.position];
          await document.reference.update({"angle": double.parse(angle!)});
        }
      });
      _dialogService.showDialog(title: 'Success', description: 'Angle updated');
    });
  }

  void changeViewTable(int index) {
    for (int i = 0; i < viewTable.length; i++) {
      viewTable[i] = i == index;
    }
    notifyListeners();
  }

  final viewTable = [true, false];

  Timer? swTimer;
  int swSecond = 0;
  int swMinute = 0;

  void startSw() {
    print("test");
    swTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (swSecond + 1 == 60) {
        swMinute++;
        swSecond = 0;
      } else {
        swSecond++;
      }
      print("called second add");
      notifyListeners();
    });
  }

  void stopSw() {
    print("cancelled");
    swTimer?.cancel();
    swTimer = null;
    notifyListeners();
  }

  void resetSw() {
    swSecond = 0;
    swMinute = 0;
    notifyListeners();
  }

  Timer? tTimer;
  int tSecond = 0;
  int tMinute = 0;

  void startT() {
    tTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (tSecond == 0 && tMinute > 0) {
        tMinute--;
        tSecond = 59;
      } else {
        if (tMinute <= 0 && tSecond <= 0) {
          tTimer?.cancel();
          tTimer = null;
        } else {
          tSecond--;
        }
      }
      notifyListeners();
    });
  }

  void stopT() {
    tTimer?.cancel();
    tTimer = null;
    notifyListeners();
  }

  void timerOperation(String operation, String type) {
    if (operation == "minute") {
      if (type == "add") {
        tMinute++;
      } else {
        if (tMinute > 0) {
          tMinute--;
        }
      }
    }
    if (operation == "second") {
      if (type == "add") {
        if (tSecond + 1 == 60) {
          tMinute++;
          tSecond = 0;
        } else {
          tSecond++;
        }
      } else {
        if (tSecond > 0) {
          tSecond--;
        }
      }
    }
    notifyListeners();
  }

  Future<void> addLapData() async {
    final data = Lap(time: "$tMinute:$tSecond");
    final docRef = await _lapService.add(data);

    final colRef = docRef.collection("points");

    _pointService.get().then((QuerySnapshot<Point> snapshot) async {
      for (var document in snapshot.docs) {
        final data = document.data();
        await colRef.add({
          "position": data.position,
          "angle": data.angle,
          "score": data.score,
          "attempt": data.attempt,
        });
      }
    });
  }

  Future<void> resetLap() async {
    _lapService.get().then((QuerySnapshot<Lap> snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        for (var document in snapshot.docs) {
          await document.reference.delete();
        }
      }
    });
    tMinute = 0;
    tSecond = 0;
    notifyListeners();
  }

  Stream<QuerySnapshot<Lap>> getLapStream() {
    return _lapService.snapshots();
  }

  Future<void> navigate(String time) async {
    await _navigationService.navigateTo(
      Routes.lapView,
      arguments: LapViewArguments(time: time),
    );
  }
}
