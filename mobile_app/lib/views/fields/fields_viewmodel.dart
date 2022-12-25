import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/app/app.locator.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:ext_video_player/ext_video_player.dart';

import '../../datamodels/point/point.dart';

class Position {
  final double x;
  final double y;

  Position(this.x, this.y);
}

class FieldsViewModel extends BaseViewModel {
  late VideoPlayerController controller;
  bool ready = false;
  final _hardwareConfigService = locator<FirestoreService>().hardwareConfig;
  final _pointService = locator<FirestoreService>().pointsCollectionReference;

  void initState() async {
    final doc = await _hardwareConfigService.get();
    final data = doc.data() as Map<String, dynamic>;
    final ip = data['ip'];

    _hardwareConfigService.snapshots().listen((event) {
      final data = event.data() as Map<String, dynamic>;
      final ip = data['ip'];
      controller =
          VideoPlayerController.network('rtmp://$ip/stream/pupils_trace');

      notifyListeners();

      controller.initialize().then((_) {
        ready = true;
        notifyListeners();
        controller.play();
      });
    });
  }

  final viewTable = [true, false, false];

  Position getPosition(int number) {
    switch (number) {
      case 1:
        return Position(150, 10);
      case 2:
        return Position(205, 30);
      case 3:
        return Position(150, 70);
      case 4:
        return Position(100, 30);
      case 5:
        return Position(255, 30);
      case 6:
        return Position(235, 80);
      case 7:
        return Position(150, 120);
      case 8:
        return Position(50, 80);
      case 9:
        return Position(20, 30);
      case 10:
        return Position(255, 150);
      case 11:
        return Position(150, 175);
      case 12:
        return Position(20, 150);
      default:
        return Position(0, 0);
    }
  }

  Position getPositionMode3(int number) {
    switch (number) {
      case 1:
        return Position(140, 10);
      case 2:
        return Position(195, 30);
      case 3:
        return Position(140, 70);
      case 4:
        return Position(80, 30);
      case 5:
        return Position(255, 10);
      case 6:
        return Position(225, 80);
      case 7:
        return Position(140, 120);
      case 8:
        return Position(45, 80);
      case 9:
        return Position(10, 10);
      case 10:
        return Position(255, 150);
      case 11:
        return Position(140, 170);
      case 12:
        return Position(20, 150);
      default:
        return Position(0, 0);
    }
  }

  void changeViewTable(int index) {
    for (int i = 0; i < viewTable.length; i++) {
      viewTable[i] = i == index;
    }
    notifyListeners();
  }

  Stream<QuerySnapshot<Point>> getScoreStream() {
    return _pointService.snapshots();
  }
}
