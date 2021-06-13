import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex/service/shared/relationShipModel/index.dart';
part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class MangaModel {
  final String result;
  final MangaDataModel data;
  final List<RelationshipsModel> relationships;

  MangaModel(this.result, this.data, this.relationships);

  factory MangaModel.fromJson(Map<String, dynamic> data) =>
      _$MangaModelFromJson(data);

  Map<String, dynamic> toJson() => _$MangaModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MangaDataModel {
  final String id;
  final String type;
  final MangaDataAttributesModel attributes;

  @JsonKey(ignore: true)
  String coverLink = "";

  MangaDataModel(this.id, this.type, this.attributes);

  factory MangaDataModel.fromJson(Map<String, dynamic> data) =>
      _$MangaDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$MangaDataModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MangaDataAttributesModel {
  final Map<String, String> title;
  final List<Map<String, String>> altTitles;
  final Map<String, String> description;
  final bool isLocked;
  final Map<String, String>? links;
  final String originalLanguage;
  final String? lastVolume;
  final String? lastChapter;
  final String? publicationDemographic;
  final String? status;
  final int? year;
  final String? contentRating;
  // TODO
  // Tipos tags
  final List<Map<String, dynamic>> tags;
  final int version;
  final String createdAt;
  final String updatedAt;

  MangaDataAttributesModel(
      this.title,
      this.altTitles,
      this.description,
      this.isLocked,
      this.links,
      this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      this.status,
      this.year,
      this.contentRating,
      this.tags,
      this.version,
      this.createdAt,
      this.updatedAt);

  factory MangaDataAttributesModel.fromJson(Map<String, dynamic> data) =>
      _$MangaDataAttributesModelFromJson(data);

  Map<String, dynamic> toJson() => _$MangaDataAttributesModelToJson(this);
}
