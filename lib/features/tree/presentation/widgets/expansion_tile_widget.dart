import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/widgets/tile_node_tree_widget.dart';

class ExpansionTileWidget extends StatelessWidget {
  const ExpansionTileWidget({
    super.key,
    this.children,
    required this.title,
    required this.typeNode,
  });

  final String title;
  final String typeNode;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      childrenPadding: const EdgeInsets.only(left: 20),
      minTileHeight: 0,
      dense: true,
      shape: Border(left: BorderSide(color: Colors.grey.shade300, width: 1)),
      showTrailingIcon: false,
      initiallyExpanded: true,
      leading: const Icon(Icons.keyboard_arrow_down_outlined),
      title: TitleNodeTreeWidget(title: title, typeNode: typeNode),
      children: children ?? [],
    );
  }
}
