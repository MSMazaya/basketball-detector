import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/app/app.locator.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _pointService = locator<FirestoreService>().pointsCollectionReference;

  Stream<QuerySnapshot<Point>> getScoreStream() {
    return _pointService.snapshots();
  }
}
