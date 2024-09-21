import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';

class AssetsController {
  final TreeRepository treeRepository;
  AssetsController(this.treeRepository);

  List<AssetsEntity> listAllAssets = [];
  List<LocationsEntity> listAlllocations = [];

  ValueNotifier<LoadingStatus> loading = ValueNotifier(LoadingStatus.loading);
  ValueNotifier<LoadingStatus> loadingAssets = ValueNotifier(LoadingStatus.loading);
  ValueNotifier<LoadingStatus> loadingLocations = ValueNotifier(LoadingStatus.loading);

  Future<void> initServicesAssetController({required String companyId}) async {
    await getAllCompaniesAssets(companyId: companyId);
    await getAllCompaniesLocations(companyId: companyId);

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
      final List<AssetsEntity> getAllCompaniesAssetsSnap = await treeRepository.getAllCompaniesAssets(
        companyId: companyId,
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
      final List<LocationsEntity> getAllCompaniesLocationsSnap =
          await treeRepository.getAllCompaniesLocations(
        companyId: companyId,
      );
      listAlllocations = getAllCompaniesLocationsSnap.toList();
      loadingLocations.value = LoadingStatus.loaded;
    } catch (e) {
      loadingLocations.value = LoadingStatus.error;
    }
  }
}
