import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_assets_usecase.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_locations_usecase.dart';

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

  Future<void> initServicesAssetController({required String companyId}) async {
    await getAllCompaniesAssets(companyId: companyId);
    await getAllCompaniesLocations(companyId: companyId);

    generateRecursiveTreeLogic();

    if (loadingLocations.value == LoadingStatus.loaded && loadingAssets.value == LoadingStatus.loaded) {
      loading.value = LoadingStatus.loaded;
    } else if (loadingLocations.value == LoadingStatus.error || loadingAssets.value == LoadingStatus.error) {
      loading.value = LoadingStatus.error;
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
    // Função recursiva que passa dentro de cada pai adicionado e percorre por todos os filhos para achar alguma dependência

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

  generateRecursiveTreeLogic() {
    // Clonando a lista de locations para não alterar a original

    for (var location in listAlllocations) {
      if (location.parentId == null) {
        _addChildLocations(location);
        _addAssetsToLocationsOrAssets(location);
      }
    }
  }

  // Função recursiva para associar assets a locais
  void _addAssetsToLocationsOrAssets(dynamic location) {
    for (var asset in listAllAssets) {
      if (asset.locationId == location.id) {
        location.children.add(asset);
        _addChildAssets(asset);
      }
    }

    // Chamada recursiva para processar filhos do local
    for (final childrenLocation in location.children) {
      _addAssetsToLocationsOrAssets(childrenLocation);
    }
  }

  // Função recursiva para adicionar locais filhos
  void _addChildLocations(LocationsEntity parent) {
    for (var location in listAlllocations) {
      if (location.parentId == parent.id) {
        parent.children.add(location);
        _addChildLocations(location);
      }
    }
  }

  // Função recursiva para adicionar assets filhos
  void _addChildAssets(AssetsEntity parent) {
    for (var asset in listAllAssets) {
      if (asset.parentId == parent.id) {
        parent.children.add(asset);
        _addChildAssets(asset);
      }
    }
  }
}
