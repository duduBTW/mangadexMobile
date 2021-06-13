// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    json['result'] as String,
    TokenModel.fromJson(json['token'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'token': instance.token.toJson(),
    };

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) {
  return TokenModel(
    json['session'] as String,
    json['refresh'] as String,
  );
}

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'session': instance.session,
      'refresh': instance.refresh,
    };
