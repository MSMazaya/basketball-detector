import 'package:freezed_annotation/freezed_annotation.dart';
part 'position_config.freezed.dart';
part 'position_config.g.dart';

@Freezed()
class PositionConfig with _$PositionConfig {
  const factory PositionConfig({
    required int position,
    required double starting_angle,
  }) = _PositionConfig;

  factory PositionConfig.fromJson(Map<String, dynamic> json) =>
      _$PositionConfigFromJson(json);
}
