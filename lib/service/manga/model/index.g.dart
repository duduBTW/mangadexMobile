// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaModel _$MangaModelFromJson(Map<String, dynamic> json) {
  return MangaModel(
    json['result'] as String,
    MangaDataModel.fromJson(json['data'] as Map<String, dynamic>),
    (json['relationships'] as List<dynamic>)
        .map((e) => RelationshipsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MangaModelToJson(MangaModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data.toJson(),
      'relationships': instance.relationships.map((e) => e.toJson()).toList(),
    };

MangaDataModel _$MangaDataModelFromJson(Map<String, dynamic> json) {
  return MangaDataModel(
    json['id'] as String,
    json['type'] as String,
    MangaDataAttributesModel.fromJson(
        json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MangaDataModelToJson(MangaDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes.toJson(),
    };

MangaDataAttributesModel _$MangaDataAttributesModelFromJson(
    Map<String, dynamic> json) {
  return MangaDataAttributesModel(
    Map<String, String>.from(json['title'] as Map),
    (json['altTitles'] as List<dynamic>)
        .map((e) => Map<String, String>.from(e as Map))
        .toList(),
    Map<String, String>.from(json['description'] as Map),
    json['isLocked'] as bool?,
    (json['links'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    json['originalLanguage'] as String,
    json['lastVolume'] as String?,
    json['lastChapter'] as String?,
    json['publicationDemographic'] as String?,
    json['status'] as String?,
    json['year'] as int?,
    json['contentRating'] as String?,
    (json['tags'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList(),
    json['version'] as int,
    json['createdAt'] as String,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$MangaDataAttributesModelToJson(
        MangaDataAttributesModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'altTitles': instance.altTitles,
      'description': instance.description,
      'isLocked': instance.isLocked,
      'links': instance.links,
      'originalLanguage': instance.originalLanguage,
      'lastVolume': instance.lastVolume,
      'lastChapter': instance.lastChapter,
      'publicationDemographic': instance.publicationDemographic,
      'status': instance.status,
      'year': instance.year,
      'contentRating': instance.contentRating,
      'tags': instance.tags,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
