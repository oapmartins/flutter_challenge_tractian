import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_assets_usecase.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_locations_usecase.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetsController {
  AssetsController(this.getAllCompaniesAssetsUsecase, this.getAllCompaniesLocationsUsecase);
  final GetAllCompaniesAssetsUsecase getAllCompaniesAssetsUsecase;
  final GetAllCompaniesLocationsUsecase getAllCompaniesLocationsUsecase;

  ValueNotifier<LoadingStatus> loading = ValueNotifier(LoadingStatus.loading);
  ValueNotifier<LoadingStatus> loadingAssets = ValueNotifier(LoadingStatus.loading);
  ValueNotifier<LoadingStatus> loadingLocations = ValueNotifier(LoadingStatus.loading);

  ValueNotifier<bool> isEnergySensorSelected = ValueNotifier(false);
  ValueNotifier<bool> isCriticalSelected = ValueNotifier(false);

  List<AssetsEntity> listAllAssets = [];
  List<LocationsEntity> listAlllocations = [];
  List<TreeNode> listTreeNode = [];

  Future<void> initServicesAssetController({required String companyId}) async {
    await getAllCompaniesAssets(companyId: companyId);
    await getAllCompaniesLocations(companyId: companyId);

    generateTreeLocations();

    if (loadingLocations.value == LoadingStatus.loaded && loadingAssets.value == LoadingStatus.loaded) {
      loading.value = LoadingStatus.loaded;
    } else if (loadingLocations.value == LoadingStatus.error || loadingAssets.value == LoadingStatus.error) {
      loading.value = LoadingStatus.error;
    }

    for (var element in listAlllocations) {
      print(element.name);
    }
  }

  Future<void> getAllCompaniesAssets({required String companyId}) async {
    loadingAssets.value = LoadingStatus.loading;
    try {
      listAllAssets.clear();
      final List<AssetsEntity> getAllCompaniesAssetsSnap = await getAllCompaniesAssetsUsecase(
        companyId,
      );
      listAllAssets = getAllCompaniesAssetsSnap.toList();
      loadingAssets.value = LoadingStatus.loaded;
    } catch (e) {
      loadingAssets.value = LoadingStatus.error;
    }
  }

  Future<void> getAllCompaniesLocations({required String companyId}) async {
    loadingLocations.value = LoadingStatus.loading;
    try {
      listAlllocations.clear();
      final List<LocationsEntity> getAllCompaniesLocationsSnap = await getAllCompaniesLocationsUsecase(
        companyId,
      );
      listAlllocations = getAllCompaniesLocationsSnap.toList();
      loadingLocations.value = LoadingStatus.loaded;
    } catch (e) {
      loadingLocations.value = LoadingStatus.error;
    }
  }

  void generateTreeLocations() {
    for (var locationsFather in listAlllocations) {
      // Vou pegar o primeiro location, e vejo se ele tem filhos
      // Caso tenha, adiciono ele como pai e os filhos em seguida.
      if (locationsFather.parentId == null) {
        listTreeNode.add(
          TreeNode(
            key: ValueKey(locationsFather.id),
            content: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.locationDot,
                  color: Color(0xff2188FF),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(locationsFather.name),
              ],
            ),
            children: [],
          ),
        );
      }

      for (var locationsSon in listAlllocations) {
        if (locationsFather.id == locationsSon.parentId) {
          listTreeNode
              .firstWhere((element) {
                return element.key.toString().contains(locationsSon.parentId ?? '');
              })
              .children
              ?.add(
                TreeNode(
                  content: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationDot,
                        color: Color(0xff2188FF),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(locationsSon.name),
                    ],
                  ),
                  children: [],
                ),
              );
        }
      }
    }
  }
}
