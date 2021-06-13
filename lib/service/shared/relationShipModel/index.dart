import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable()
class RelationshipsModel {
  final String id;
  final String type;
  final dynamic attributes;

  RelationshipsModel(this.id, this.type, this.attributes);

  factory RelationshipsModel.fromJson(Map<String, dynamic> data) =>
      _$RelationshipsModelFromJson(data);

  Map<String, dynamic> toJson() => _$RelationshipsModelToJson(this);
}
