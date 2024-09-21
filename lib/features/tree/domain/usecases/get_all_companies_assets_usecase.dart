import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';

class GetAllCompaniesAssetsUsecase {
  final TreeRepository _treeRepository;

  GetAllCompaniesAssetsUsecase(this._treeRepository);

  Future<List<AssetsEntity>> call(String params) {
    return _treeRepository.getAllCompaniesAssets(companyId: params);
  }
}
