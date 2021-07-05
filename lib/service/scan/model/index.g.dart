// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanlationGroupDataModel _$ScanlationGroupDataModelFromJson(
    Map<String, dynamic> json) {
  return ScanlationGroupDataModel(
    json['id'] as String,
    json['type'] as String,
    ScanlationGroupattributesModel.fromJson(
        json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ScanlationGroupDataModelToJson(
        ScanlationGroupDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes.toJson(),
    };

ScanlationGroupattributesModel _$ScanlationGroupattributesModelFromJson(
    Map<String, dynamic> json) {
  return ScanlationGroupattributesModel(
    json['name'] as String,
    json['leader'],
    json['version'] as int,
    json['createdAt'] as String,
    json['updatedAt'] as String,
    json['members'],
  );
}

Map<String, dynamic> _$ScanlationGroupattributesModelToJson(
        ScanlationGroupattributesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'leader': instance.leader,
      'members': instance.members,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
