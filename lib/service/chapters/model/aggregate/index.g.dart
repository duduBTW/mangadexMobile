// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaAgreModel _$MangaAgreModelFromJson(Map<String, dynamic> json) {
  return MangaAgreModel(
    (json['volumes'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, ChaptersVolumeModel.fromJson(e as Map<String, dynamic>)),
    ),
    json['result'] as String,
  );
}

Map<String, dynamic> _$MangaAgreModelToJson(MangaAgreModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'volumes': instance.volumes.map((k, e) => MapEntry(k, e.toJson())),
    };

ChaptersVolumeModel _$ChaptersVolumeModelFromJson(Map<String, dynamic> json) {
  return ChaptersVolumeModel(
    json['volume'] as String,
    json['count'] as int,
    (json['chapters'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, ChaptersItemModel.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$ChaptersVolumeModelToJson(
        ChaptersVolumeModel instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'count': instance.count,
      'chapters': instance.chapters.map((k, e) => MapEntry(k, e.toJson())),
    };

ChaptersItemModel _$ChaptersItemModelFromJson(Map<String, dynamic> json) {
  return ChaptersItemModel(
    json['chapter'] as String,
    json['count'] as int,
  );
}

Map<String, dynamic> _$ChaptersItemModelToJson(ChaptersItemModel instance) =>
    <String, dynamic>{
      'chapter': instance.chapter,
      'count': instance.count,
    };
