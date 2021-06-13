// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoverModel _$CoverModelFromJson(Map<String, dynamic> json) {
  return CoverModel(
    json['result'] as String,
    DataModel.fromJson(json['data'] as Map<String, dynamic>),
    (json['relationships'] as List<dynamic>)
        .map((e) => RelationshipsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CoverModelToJson(CoverModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data.toJson(),
      'relationships': instance.relationships.map((e) => e.toJson()).toList(),
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return DataModel(
    json['id'] as String,
    json['type'] as String,
    CoverDataModel.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes.toJson(),
    };

CoverDataModel _$CoverDataModelFromJson(Map<String, dynamic> json) {
  return CoverDataModel(
    json['volume'] as String?,
    json['fileName'] as String,
    json['description'] as String?,
    json['version'] as int,
    json['createdAt'] as String,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$CoverDataModelToJson(CoverDataModel instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'fileName': instance.fileName,
      'description': instance.description,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
