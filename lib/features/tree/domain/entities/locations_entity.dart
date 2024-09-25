class LocationsEntity {
  final String id;
  final String name;
  final String? parentId;
  List<dynamic> children = [];

  LocationsEntity({
    required this.id,
    required this.name,
    this.parentId,
  });

  void addChild(dynamic child) {
    children.add(child);
  }
}
