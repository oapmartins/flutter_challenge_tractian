import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';

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

   LocationsEntity deepCopy() {
    List<dynamic> copiedChildren = children.map((child) {
      if (child is LocationsEntity) {
        return child.deepCopy();
      } else if (child is AssetsEntity) {
        return child.deepCopy();
      }
      return child;
    }).toList();

    return LocationsEntity(
      id: id,
      name: name,
      parentId: parentId,
    )..children = copiedChildren;
  }
}
