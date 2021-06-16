// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) {
  return ChapterModel(
    json['id'] as String,
    json['type'] as String,
    ChaptersAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes.toJson(),
    };

ChaptersAttributes _$ChaptersAttributesFromJson(Map<String, dynamic> json) {
  return ChaptersAttributes(
    json['title'] as String,
    json['volume'] as String?,
    json['chapter'] as String?,
    json['translatedLanguage'] as String,
    json['hash'] as String,
    (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    json['uploader'] as String?,
    json['version'] as int,
    json['createdAt'] as String,
    json['updatedAt'] as String,
    json['publishAt'] as String,
  );
}

Map<String, dynamic> _$ChaptersAttributesToJson(ChaptersAttributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'volume': instance.volume,
      'chapter': instance.chapter,
      'translatedLanguage': instance.translatedLanguage,
      'hash': instance.hash,
      'data': instance.data,
      'dataSaver': instance.dataSaver,
      'uploader': instance.uploader,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishAt': instance.publishAt,
    };
