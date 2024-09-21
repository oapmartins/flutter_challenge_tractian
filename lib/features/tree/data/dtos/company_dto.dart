import 'package:flutter_challenge_tractian/features/tree/domain/entities/company_entity.dart';

class CompanyDto {
  final String id;
  final String name;

  CompanyDto({
    required this.id,
    required this.name,
  });

  factory CompanyDto.fromEntity(CompanyEntity entity) {
    return CompanyDto(
      id: entity.id,
      name: entity.name,
    );
  }

  CompanyEntity toEntity() {
    return CompanyEntity(
      id: id,
      name: name,
    );
  }

  factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
