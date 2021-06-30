// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagsModel _$TagsModelFromJson(Map<String, dynamic> json) {
  return TagsModel(
    json['result'] as String,
    TagsDataModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TagsModelToJson(TagsModel instance) => <String, dynamic>{
      'result': instance.result,
      'data': instance.data.toJson(),
    };

TagsDataModel _$TagsDataModelFromJson(Map<String, dynamic> json) {
  return TagsDataModel(
    json['id'] as String,
    json['type'] as String,
    TagsAttributesModel.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TagsDataModelToJson(TagsDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes.toJson(),
    };

TagsAttributesModel _$TagsAttributesModelFromJson(Map<String, dynamic> json) {
  return TagsAttributesModel(
    Map<String, String>.from(json['name'] as Map),
    json['group'] as String,
    json['version'] as int,
  );
}

Map<String, dynamic> _$TagsAttributesModelToJson(
        TagsAttributesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group': instance.group,
      'version': instance.version,
    };
