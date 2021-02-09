import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Groups {
  final String id;
  @JsonKey(name: 'group_id')
  final String groupId;
  @JsonKey(name: 'host_id')
  final String hostId;

  Groups({this.id, this.groupId, this.hostId});

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);
  Map<String, dynamic> toJson() => _$GroupsToJson(this);
}

