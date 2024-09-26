import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_assets_usecase.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_locations_usecase.dart';

class TreeController {
  TreeController(this.getAllCompaniesAssetsUsecase, this.getAllCompaniesLocationsUsecase);
  final GetAllCompaniesAssetsUsecase getAllCompaniesAssetsUsecase;
  final GetAllCompaniesLocationsUsecase getAllCompaniesLocationsUsecase;

  ValueNotifier<LoadingStatus> loading = ValueNotifier(LoadingStatus.loading);
  ValueNotifier<LoadingStatus> loadingAssets = ValueNotifier(LoadingStatus.loading);
  ValueNotifier<LoadingStatus> loadingLocations = ValueNotifier(LoadingStatus.loading);

  ValueNotifier<bool> isEnergySensorSelected = ValueNotifier(false);
  ValueNotifier<bool> isCriticalSelected = ValueNotifier(false);

  List<AssetsEntity> listAllAssetsBKP = [];
  List<LocationsEntity> listAlllocationsBKP = [];
  List<dynamic> listTreeBKP = [];

  List<dynamic> listTree = [];
  List<dynamic> listAllAssets = [];

  TextEditingController searchController = TextEditingController();

  // Funções de init e consulta
  Future<void> initServicesAssetController({required String companyId}) async {
    // Carregando os dois juntos para otimizar o tempo.
    await Future.wait([
      getAllCompaniesAssets(companyId: companyId),
      getAllCompaniesLocations(companyId: companyId),
    ]);

    generateRecursiveTreeLogic();

    // Fazendo uma cópia do estado da lista para evitar reconstrução ao fazer filtro
    listTreeBKP = listTree.map((nodes) => nodes.deepCopy()).toList();

    if (loadingLocations.value == LoadingStatus.loaded && loadingAssets.value == LoadingStatus.loaded) {
      loading.value = LoadingStatus.loaded;
    } else if (loadingLocations.value == LoadingStatus.error || loadingAssets.value == LoadingStatus.error) {
      loading.value = LoadingStatus.error;
    }
  }

  Future<void> getAllCompaniesAssets({required String companyId}) async {
    loadingAssets.value = LoadingStatus.loading;
    try {
      listAllAssetsBKP.clear();
      final List<AssetsEntity> getAllCompaniesAssetsSnap = await getAllCompaniesAssetsUsecase(
        companyId,
      );
      listAllAssetsBKP = getAllCompaniesAssetsSnap.toList();
      listAllAssets = listAllAssetsBKP.map((asset) => asset.deepCopy()).toList();
      loadingAssets.value = LoadingStatus.loaded;
    } catch (e) {
      loadingAssets.value = LoadingStatus.error;
    }
  }

  Future<void> getAllCompaniesLocations({required String companyId}) async {
    // Função recursiva que passa dentro de cada pai adicionado e percorre por todos os filhos para achar alguma dependência

    loadingLocations.value = LoadingStatus.loading;
    try {
      listAlllocationsBKP.clear();
      final List<LocationsEntity> getAllCompaniesLocationsSnap = await getAllCompaniesLocationsUsecase(
        companyId,
      );
      listAlllocationsBKP = getAllCompaniesLocationsSnap.toList();
      listTree = listAlllocationsBKP.map((location) => location.deepCopy()).toList();

      loadingLocations.value = LoadingStatus.loaded;
    } catch (e) {
      loadingLocations.value = LoadingStatus.error;
    }
  }

  // Funções referentes a árvore de widgets.
  void generateRecursiveTreeLogic() {
    for (var location in listTree) {
      if (location.parentId == null) {
        _addChildLocations(location);
        _addAssetsToLocationsOrAssets(location);
      }
    }

    // Adicionando os assets que não tem pais nem locations
    listTree = [
      ...listAllAssets.where((asset) => asset.locationId == null && asset.parentId == null),
      ...listTree
    ].toList();

    // Ordenar a lista de locais por quantidade de filhos
    listTree.sort((a, b) {
      return (b?.children.length ?? 0).compareTo((a?.children.length ?? 0));
    });
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
  void _addChildLocations(dynamic parent) {
    for (var location in listTree) {
      if (location.parentId == parent.id) {
        parent.children.add(location);
        _addChildLocations(location);
      }
    }
  }

  // Função recursiva para adicionar assets filhos
  void _addChildAssets(dynamic parent) {
    for (var asset in listAllAssets) {
      if (asset.parentId == parent.id) {
        parent.children.add(asset);
        _addChildAssets(asset);
      }
    }
  }

  // Função de filtro
  void filterTree() {
    try {
      loading.value = LoadingStatus.loading;

      // Toda vez que eu for filtrar, eu preciso resetar a lista de assets e gerar a árvore novamente.
      // Estou fazendo isso de um BKP para otimizar os processos.
      // Só vou limpar a lista se não tiver filtros selecionados.
      listTree = listTreeBKP.map((nodes) => nodes.deepCopy()).toList();

      if (isCriticalSelected.value == true ||
          isEnergySensorSelected.value == true ||
          searchController.text.isNotEmpty) {
        for (var item in listTree) {
          if (item is LocationsEntity) {
            _filterLocations(item, listTree);
          }
        }

        listTree.removeWhere(
          (element) =>
              element is LocationsEntity && element.children.isEmpty ||
              element is AssetsEntity && !validAsset(element),
        );
      }

      loading.value = LoadingStatus.loaded;
    } catch (e) {
      loading.value = LoadingStatus.error;
    }
  }

  void _filterLocations(dynamic location, List listFather) {
    // Se o local corresponde à busca, não precisa filtrar mais seus filhos

    // Está dando problema no filtro de locate
    // bool isLocatedMatch = location is LocationsEntity &&
    //     searchController.text.isNotEmpty &&
    //     location.name.toLowerCase().contains(searchController.text.toLowerCase());

    _filterChildren(location);
  }

  void _filterAssets(dynamic asset, List listRemove) {
    _filterChildren(asset);

    if (asset.children.isEmpty && !validAsset(asset)) {
      listRemove.remove(asset);
    }
  }

  void _filterChildren(dynamic parent) {
    for (int i = parent.children.length - 1; i >= 0; i--) {
      var child = parent.children[i];

      if (child is LocationsEntity) {
        _filterLocations(child, parent.children);
        if (child.children.isEmpty) {
          parent.children.removeAt(i);
        }
      } else if (child is AssetsEntity) {
        _filterAssets(child, parent.children);
      }
    }
  }

  bool validAsset(AssetsEntity asset) {
    // Verificar se o filtro de busca está ativo
    bool isSearchMatch = searchController.text.isNotEmpty
        ? asset.name.toLowerCase().contains(searchController.text.toLowerCase())
        : true;

    // Verificar se o filtro de sensor de energia está ativo
    bool isEnergyMatch = isEnergySensorSelected.value ? asset.sensorType == 'energy' : true;

    // Verificar se o filtro de crítico está ativo
    bool isCriticalMatch = isCriticalSelected.value ? asset.status == 'alert' : true;

    // O ativo é válido se todos os critérios forem verdadeiros
    return isSearchMatch && isEnergyMatch && isCriticalMatch;
  }
}
