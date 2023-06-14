// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropDownModel _$DropDownModelFromJson(Map<String, dynamic> json) =>
    DropDownModel(
      value: json['value'] ?? '',
      key: json['key'] as String? ?? '',
    );

Map<String, dynamic> _$DropDownModelToJson(DropDownModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
