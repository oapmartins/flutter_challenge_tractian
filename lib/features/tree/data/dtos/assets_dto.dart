// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';

class AssetsDto {
  final String id;
  final String name;
  final String? sensorType;
  final String? status;
  final String? parentId;
  final String? locationId;
  final String? gatewayId;

  AssetsDto({
    required this.id,
    required this.name,
    this.sensorType,
    this.status,
    this.parentId,
    this.locationId,
    this.gatewayId,
  });

  factory AssetsDto.fromEntity(AssetsEntity entity) {
    return AssetsDto(
      id: entity.id,
      name: entity.name,
      sensorType: entity.sensorType,
      status: entity.status,
      parentId: entity.parentId,
      locationId: entity.locationId,
      gatewayId: entity.gatewayId,
    );
  }

  AssetsEntity toEntity() {
    return AssetsEntity(
      id: id,
      name: name,
      sensorType: sensorType,
      status: status,
      parentId: parentId,
      locationId: locationId,
      gatewayId: gatewayId,
    );
  }

  factory AssetsDto.fromJson(Map<String, dynamic> json) {
    return AssetsDto(
      id: json['id'],
      name: json['name'],
      sensorType: json['sensorType'],
      status: json['status'],
      parentId: json['parentId'],
      locationId: json['locationId'],
      gatewayId: json['gatewayId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sensorType': sensorType,
      'status': status,
      'parentId': parentId,
      'locationId': locationId,
      'gatewayId': gatewayId,
    };
  }
}
