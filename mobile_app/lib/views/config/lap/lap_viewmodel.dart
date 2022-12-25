import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/app/app.locator.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LapViewModel extends BaseViewModel {
  final _pointService = locator<FirestoreService>().pointsCollectionReference;
  final _lapService = locator<FirestoreService>().lapCollection;
  final _dialogService = locator<DialogService>();

  Future<QuerySnapshot<Point>> getScoreStream(String time) async {
    final docRef =
        await _lapService.where('time', isEqualTo: time).limit(1).get();
    final doc = docRef.docs[0];
    return await doc.reference
        .collection('points')
        .withConverter<Point>(
          fromFirestore: (snapshot, _) => Point.fromJson(snapshot.data()!),
          toFirestore: (point, _) => point.toJson(),
        )
        .get();
  }

  void resetScore() {
    // iterate _pointService, and get the docs
    _pointService.get().then((QuerySnapshot<Point> snapshot) async {
      snapshot.docs.forEach((DocumentSnapshot<Point> document) async {
        await document.reference.update({'score': 0});
      });
      await _dialogService.showDialog(
          title: 'Success', description: 'Score updated');
    });
  }
}
