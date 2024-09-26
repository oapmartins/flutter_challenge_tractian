import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/tree_controller.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/widgets/chips_filter_widget.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/widgets/recursive_tree_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class TreePage extends StatefulWidget {
  const TreePage({
    super.key,
    required this.companyId,
  });

  final String companyId;

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  final TreeController _treeController = GetIt.I<TreeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _treeController.initServicesAssetController(companyId: widget.companyId);
    });

    super.initState();
  }

  @override
  void dispose() {
    GetIt.I.resetLazySingleton<TreeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Assets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                  child: TextField(
                    controller: _treeController.searchController,
                    onChanged: (value) {
                      _treeController.filterTree();
                    },
                    style: const TextStyle(
                      color: Color(0xff8E98A3),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 18,
                        color: Color(0xff8E98A3),
                      ),
                      fillColor: const Color(0xffEAEFF3),
                      filled: true,
                      hintText: 'Buscar Ativo ou Local',
                      hintStyle: const TextStyle(
                        color: Color(0xff8E98A3),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 10.0, // Espaço entre os chips
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: _treeController.isEnergySensorSelected,
                        builder: (BuildContext context, bool selected, child) {
                          return ChipFilterWidget(
                            isSelected: _treeController.isEnergySensorSelected,
                            textLabel: 'Sensor de Energia',
                            icon: Icons.bolt,
                            onTap: _treeController.filterTree,
                          );
                        }),
                    ValueListenableBuilder<bool>(
                      valueListenable: _treeController.isCriticalSelected,
                      builder: (BuildContext context, bool selected, child) {
                        return ChipFilterWidget(
                          isSelected: _treeController.isCriticalSelected,
                          textLabel: 'Crítico',
                          icon: FontAwesomeIcons.circleExclamation,
                          iconSize: 14,
                          onTap: _treeController.filterTree,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: _treeController.loading,
              builder: (BuildContext context, LoadingStatus loadingStatus, child) {
                if (loadingStatus == LoadingStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (loadingStatus == LoadingStatus.error) {
                  return const Center(
                    child: Text('Error ao carregar árvore'),
                  );
                } else if (loadingStatus == LoadingStatus.loaded && _treeController.listTree.isEmpty) {
                  return const Center(
                    child: Text('Nenhum ativo encontrado'),
                  );
                }
                return RecursiveTreeWidget(
                  rootLocations: _treeController.listTree,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
