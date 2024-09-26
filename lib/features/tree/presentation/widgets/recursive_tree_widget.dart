import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/widgets/expansion_tile_widget.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/widgets/tile_node_tree_widget.dart';

class RecursiveTreeWidget extends StatelessWidget {
  final List<dynamic> rootLocations;

  const RecursiveTreeWidget({super.key, required this.rootLocations});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildLocationWidgets(rootLocations),
    );
  }

  // Função recursiva para criar widgets de localização
  List<Widget> _buildLocationWidgets(List<dynamic> locations) {
    List<Widget> widgets = [];
    for (var location in locations) {
      if (location is LocationsEntity) {
        if (location.children.isEmpty) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TitleNodeTreeWidget(
                title: location.name,
                typeNode: 'location',
              ),
            ),
          );
        } else {
          widgets.add(
            ExpansionTileWidget(
              typeNode: 'location',
              title: location.name,
              children: _buildChildWidgets(location.children),
            ),
          );
        }
      } else if (location is AssetsEntity) {
        if (location.children.isEmpty) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TitleNodeTreeWidget(
                title: location.name,
                typeNode: '',
                sensorStatus: location.status,
                sensorType: location.sensorType,
              ),
            ),
          );
        } else {
          widgets.add(
            ExpansionTileWidget(
              typeNode: 'asset',
              title: location.name,
              children: _buildChildWidgets(location.children),
            ),
          );
        }
      }
    }
    return widgets;
  }

  // Função recursiva para criar widgets de filhos (que podem ser localizações ou ativos)
  List<Widget> _buildChildWidgets(List<dynamic> children) {
    List<Widget> childWidgets = [];
    for (var child in children) {
      if (child is LocationsEntity) {
        // Se for um local, cria um ExpansionTile recursivamente
        childWidgets.add(
          ExpansionTileWidget(
            typeNode: 'location',
            title: child.name,
            children: _buildChildWidgets(child.children),
          ),
        );
      } else if (child is AssetsEntity) {
        // Se for um ativo, exibe um ListTile

        if (child.children.isEmpty) {
          childWidgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: TitleNodeTreeWidget(
                title: child.name,
                typeNode: '',
                sensorStatus: child.status,
                sensorType: child.sensorType,
              ),
            ),
          );
        } else {
          childWidgets.add(
            ExpansionTileWidget(
              typeNode: 'asset',
              title: child.name,
              children: _buildChildWidgets(child.children),
            ),
          );
        }
      }
    }
    return childWidgets;
  }
}
