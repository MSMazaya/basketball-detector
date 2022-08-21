import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/app/app.locator.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:stacked/stacked.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'config_view.form.dart';

class ConfigViewModel extends FormViewModel {
  final _pointService = locator<FirestoreService>().pointsCollectionReference;
  final _dialogService = locator<DialogService>();

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

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
    valueMap = {
      1: angle1Value,
      2: angle2Value,
      3: angle3Value,
      4: angle4Value,
      5: angle5Value,
    };
    print(valueMap[1]);
  }
}
