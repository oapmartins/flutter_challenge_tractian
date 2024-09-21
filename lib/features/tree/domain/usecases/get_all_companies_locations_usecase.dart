import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';

class GetAllCompaniesLocationsUsecase {
  final TreeRepository _treeRepository;

  GetAllCompaniesLocationsUsecase(this._treeRepository);

  Future<List<LocationsEntity>> call(String params) {
    return _treeRepository.getAllCompaniesLocations(companyId: params);
  }
}
