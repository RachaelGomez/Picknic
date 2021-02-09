// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) {
  return Groups(
    id: json['id'] as String,
    groupId: json['group_id'] as String,
    hostId: json['host_id'] as String,
  );
}

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'host_id': instance.hostId,
    };
