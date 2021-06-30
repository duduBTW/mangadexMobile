import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class ChapterModel {
  final ChapterDataModel data;
  final List<Map<String, dynamic>?> relationships;

  ChapterModel(this.data, this.relationships);

  factory ChapterModel.fromJson(Map<String, dynamic> data) =>
      _$ChapterModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChapterDataModel {
  final String id;
  final String type;
  final ChaptersAttributes attributes;

  ChapterDataModel(this.id, this.type, this.attributes);

  factory ChapterDataModel.fromJson(Map<String, dynamic> data) =>
      _$ChapterDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChapterDataModelToJson(this);
}

@JsonSerializable()
class ChaptersAttributes {
  final String? title;
  final String? volume;
  final String? chapter;
  final String? translatedLanguage;
  final String? hash;
  final List<String?> data;
  final List<String?> dataSaver;
  final String? uploader;
  final int version;
  final String createdAt;
  final String updatedAt;
  final String publishAt;

  ChaptersAttributes(
      this.title,
      this.volume,
      this.chapter,
      this.translatedLanguage,
      this.hash,
      this.data,
      this.dataSaver,
      this.uploader,
      this.version,
      this.createdAt,
      this.updatedAt,
      this.publishAt);

  factory ChaptersAttributes.fromJson(Map<String, dynamic> data) =>
      _$ChaptersAttributesFromJson(data);

  Map<String, dynamic> toJson() => _$ChaptersAttributesToJson(this);
}
