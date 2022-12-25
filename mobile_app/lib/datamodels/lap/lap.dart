import 'package:freezed_annotation/freezed_annotation.dart';
part 'lap.freezed.dart';
part 'lap.g.dart';

@Freezed()
class Lap with _$Lap {
  const factory Lap({
    required String time,
  }) = _Lap;

  factory Lap.fromJson(Map<String, dynamic> json) => _$LapFromJson(json);
}
