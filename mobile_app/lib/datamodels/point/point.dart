import 'package:freezed_annotation/freezed_annotation.dart';
part 'point.freezed.dart';
part 'point.g.dart';

@Freezed()
class Point with _$Point {
  const factory Point({
    required int score,
    required int position,
    required double angle,
    required int attempt,
  }) = _Point;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}
