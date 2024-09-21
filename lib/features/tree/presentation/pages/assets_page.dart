import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/assets_controller.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({
    super.key,
    required this.companyId,
  });

  final String companyId;

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AssetsController _assetsController = GetIt.I<AssetsController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _assetsController.initServicesAssetController(companyId: widget.companyId);
    });

    super.initState();
  }

  @override
  void dispose() {
    GetIt.I.resetLazySingleton<AssetsController>();
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
                        valueListenable: _assetsController.isEnergySensorSelected,
                        builder: (BuildContext context, bool selected, child) {
                          return ChipFilterWidget(
                            isSelected: _assetsController.isEnergySensorSelected,
                            textLabel: 'Sendor de Energia',
                            icon: Icons.bolt,
                          );
                        }),
                    ValueListenableBuilder<bool>(
                      valueListenable: _assetsController.isCriticalSelected,
                      builder: (BuildContext context, bool selected, child) {
                        return ChipFilterWidget(
                          isSelected: _assetsController.isCriticalSelected,
                          textLabel: 'Crítico',
                          icon: FontAwesomeIcons.circleExclamation,
                          iconSize: 14,
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
          Expanded(
            child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: _assetsController.loadingLocations,
              builder: (BuildContext context, LoadingStatus loadingStatus, child) {
                if (loadingStatus == LoadingStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (loadingStatus == LoadingStatus.error) {
                  return const Center(
                    child: Text('Error ao consultar assets'),
                  );
                }
                return TreeView(
                  
                  nodes: _assetsController.listTreeNode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChipFilterWidget extends StatelessWidget {
  const ChipFilterWidget({
    super.key,
    required this.isSelected,
    required this.textLabel,
    required this.icon,
    this.iconSize,
  });

  final ValueNotifier<bool> isSelected;
  final String textLabel;
  final IconData icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FilterChip(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        label: Text(textLabel),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: isSelected.value ? Colors.white : const Color(0xff77818C),
          fontSize: 14,
        ),
        avatar: Icon(
          icon,
          color: isSelected.value ? Colors.white : const Color(0xff77818C),
          size: iconSize ?? 18,
        ),
        side: BorderSide(
          width: .7,
          color: isSelected.value ? const Color(0xff2188FF) : Colors.grey.shade400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        selected: isSelected.value,
        showCheckmark: false,
        selectedColor: const Color(0xff2188FF),
        backgroundColor: Colors.white,
        onSelected: (bool selected) {
          isSelected.value = selected;
        },
      ),
    );
  }
}
