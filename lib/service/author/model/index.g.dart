// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) {
  return AuthorModel(
    json['result'] as String,
    json['relationships'] as List<dynamic>,
    AuthorDataModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthorModelToJson(AuthorModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'relationships': instance.relationships,
      'data': instance.data.toJson(),
    };

AuthorDataModel _$AuthorDataModelFromJson(Map<String, dynamic> json) {
  return AuthorDataModel(
    json['id'] as String,
    json['type'] as String,
    AuthorAttributesModel.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthorDataModelToJson(AuthorDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes.toJson(),
    };

AuthorAttributesModel _$AuthorAttributesModelFromJson(
    Map<String, dynamic> json) {
  return AuthorAttributesModel(
    json['name'] as String,
    json['imageUrl'] as String?,
    json['biography'],
    json['version'] as int,
    json['createdAt'] as String,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$AuthorAttributesModelToJson(
        AuthorAttributesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'biography': instance.biography,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
