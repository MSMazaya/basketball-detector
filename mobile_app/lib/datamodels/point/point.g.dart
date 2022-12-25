// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Point _$$_PointFromJson(Map<String, dynamic> json) => _$_Point(
      score: json['score'] as int,
      position: json['position'] as int,
      angle: (json['angle'] as num).toDouble(),
      attempt: json['attempt'] as int,
    );

Map<String, dynamic> _$$_PointToJson(_$_Point instance) => <String, dynamic>{
      'score': instance.score,
      'position': instance.position,
      'angle': instance.angle,
      'attempt': instance.attempt,
    };
