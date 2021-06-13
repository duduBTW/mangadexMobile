import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginModel {
  final String result;
  final TokenModel token;

  LoginModel(this.result, this.token);

  factory LoginModel.fromJson(Map<String, dynamic> data) =>
      _$LoginModelFromJson(data);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class TokenModel {
  String session, refresh;

  TokenModel(this.session, this.refresh);

  factory TokenModel.fromJson(Map<String, dynamic> data) =>
      _$TokenModelFromJson(data);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
