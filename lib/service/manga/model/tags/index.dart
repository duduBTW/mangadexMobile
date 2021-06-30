import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class TagsModel {
  final String result;
  final TagsDataModel data;

  TagsModel(this.result, this.data);

  factory TagsModel.fromJson(Map<String, dynamic> data) =>
      _$TagsModelFromJson(data);

  Map<String, dynamic> toJson() => _$TagsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TagsDataModel {
  final String id;
  final String type;
  final TagsAttributesModel attributes;

  TagsDataModel(this.id, this.type, this.attributes);

  factory TagsDataModel.fromJson(Map<String, dynamic> data) =>
      _$TagsDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$TagsDataModelToJson(this);
}

@JsonSerializable()
class TagsAttributesModel {
  final Map<String, String> name;
  final String group;
  final int version;

  TagsAttributesModel(this.name, this.group, this.version);

  factory TagsAttributesModel.fromJson(Map<String, dynamic> data) =>
      _$TagsAttributesModelFromJson(data);

  Map<String, dynamic> toJson() => _$TagsAttributesModelToJson(this);
}
