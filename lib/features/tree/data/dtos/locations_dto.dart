import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';

class LocationsDto {
  final String id;
  final String name;
  final String? parentId;

  LocationsDto({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory LocationsDto.fromEntity(LocationsEntity entity) {
    return LocationsDto(
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId,
    );
  }

  LocationsEntity toEntity() {
    return LocationsEntity(
      id: id,
      name: name,
      parentId: parentId,
    );
  }

  factory LocationsDto.fromJson(Map<String, dynamic> json) {
    return LocationsDto(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }
}
