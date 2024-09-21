class LocationsEntity {
  final String id;
  final String name;
  final String? parentId;

  LocationsEntity({
    required this.id,
    required this.name,
    this.parentId,
  });
}
