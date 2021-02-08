class Group {
  final String hostId;
  final String groupName;
  final int id;

  Group({this.hostId, this.groupName, this.id});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      hostId: json['hostId'],
      groupName: json['groupName'],
      id: json['id']
    );
  }
}