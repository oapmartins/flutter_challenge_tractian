class AssetsEntity {
  final String id;
  final String name;
  final String? sensorType;
  final String? status;
  final String? parentId;
  final String? locationId;
  final String? gatewayId;

  AssetsEntity({
    required this.id,
    required this.name,
    this.sensorType,
    this.status,
    this.parentId,
    this.locationId,
    this.gatewayId,
  });
}
