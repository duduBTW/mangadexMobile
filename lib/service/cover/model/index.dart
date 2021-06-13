import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex/service/shared/relationShipModel/index.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class CoverModel {
  final String result;
  final DataModel data;
  final List<RelationshipsModel> relationships;

  CoverModel(this.result, this.data, this.relationships);

  factory CoverModel.fromJson(Map<String, dynamic> data) =>
      _$CoverModelFromJson(data);

  Map<String, dynamic> toJson() => _$CoverModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataModel {
  final String id;
  final String type;
  final CoverDataModel attributes;

  DataModel(this.id, this.type, this.attributes);

  factory DataModel.fromJson(Map<String, dynamic> data) =>
      _$DataModelFromJson(data);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

@JsonSerializable()
class CoverDataModel {
  final String? volume;
  final String fileName;
  final String? description;
  final int version;
  final String createdAt;
  final String updatedAt;

  CoverDataModel(this.volume, this.fileName, this.description, this.version,
      this.createdAt, this.updatedAt);

  factory CoverDataModel.fromJson(Map<String, dynamic> data) =>
      _$CoverDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$CoverDataModelToJson(this);
}
