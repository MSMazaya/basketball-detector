import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:mobile_app/datamodels/position_config/position_config.dart';

class FirestoreService {
  final CollectionReference<Point> pointsCollectionReference =
      FirebaseFirestore.instance.collection('points').withConverter<Point>(
            fromFirestore: (snapshot, _) => Point.fromJson(snapshot.data()!),
            toFirestore: (point, _) => point.toJson(),
          );

  final CollectionReference<PositionConfig> positionConfigCollectionReference =
      FirebaseFirestore.instance
          .collection('position_config')
          .withConverter<PositionConfig>(
            fromFirestore: (snapshot, _) =>
                PositionConfig.fromJson(snapshot.data()!),
            toFirestore: (position_config, _) => position_config.toJson(),
          );
}
