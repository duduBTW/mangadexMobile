import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class ScanlationGroupDataModel {
  final String id;
  final String type;
  final ScanlationGroupattributesModel attributes;

  ScanlationGroupDataModel(this.id, this.type, this.attributes);

  factory ScanlationGroupDataModel.fromJson(Map<String, dynamic> data) =>
      _$ScanlationGroupDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$ScanlationGroupDataModelToJson(this);
}

@JsonSerializable()
class ScanlationGroupattributesModel {
  final String name;
  final dynamic leader;
  final dynamic members;
  final int version;
  final String createdAt;
  final String updatedAt;

  ScanlationGroupattributesModel(
    this.name,
    this.leader,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.members,
  );

  factory ScanlationGroupattributesModel.fromJson(Map<String, dynamic> data) =>
      _$ScanlationGroupattributesModelFromJson(data);

  Map<String, dynamic> toJson() => _$ScanlationGroupattributesModelToJson(this);
}
