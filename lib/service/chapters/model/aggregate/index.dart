import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class MangaAgreModel {
  final String result;
  final Map<String, ChaptersVolumeModel> volumes;

  MangaAgreModel(this.volumes, this.result);

  factory MangaAgreModel.fromJson(Map<String, dynamic> data) =>
      _$MangaAgreModelFromJson(data);

  Map<String, dynamic> toJson() => _$MangaAgreModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChaptersVolumeModel {
  final String volume;
  final int count;
  final Map<String, ChaptersItemModel> chapters;

  ChaptersVolumeModel(this.volume, this.count, this.chapters);

  factory ChaptersVolumeModel.fromJson(Map<String, dynamic> data) =>
      _$ChaptersVolumeModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChaptersVolumeModelToJson(this);
}

@JsonSerializable()
class ChaptersItemModel {
  final String chapter;
  final int count;

  ChaptersItemModel(this.chapter, this.count);

  factory ChaptersItemModel.fromJson(Map<String, dynamic> data) =>
      _$ChaptersItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChaptersItemModelToJson(this);
}
