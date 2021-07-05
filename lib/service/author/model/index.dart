import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthorModel {
  final String result;
  final List<dynamic> relationships;
  final AuthorDataModel data;

  AuthorModel(this.result, this.relationships, this.data);
  factory AuthorModel.fromJson(Map<String, dynamic> data) =>
      _$AuthorModelFromJson(data);

  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthorDataModel {
  final String id;
  final String type;
  final AuthorAttributesModel attributes;

  AuthorDataModel(this.id, this.type, this.attributes);
  factory AuthorDataModel.fromJson(Map<String, dynamic> data) =>
      _$AuthorDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$AuthorDataModelToJson(this);
}

@JsonSerializable()
class AuthorAttributesModel {
  final String name;
  final String? imageUrl;
  final dynamic biography;
  final int version;
  final String createdAt;
  final String updatedAt;

  AuthorAttributesModel(this.name, this.imageUrl, this.biography, this.version,
      this.createdAt, this.updatedAt);
  factory AuthorAttributesModel.fromJson(Map<String, dynamic> data) =>
      _$AuthorAttributesModelFromJson(data);

  Map<String, dynamic> toJson() => _$AuthorAttributesModelToJson(this);
}
