// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipsModel _$RelationshipsModelFromJson(Map<String, dynamic> json) {
  return RelationshipsModel(
    json['id'] as String,
    json['type'] as String,
    json['attributes'],
  );
}

Map<String, dynamic> _$RelationshipsModelToJson(RelationshipsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
    };
