import 'package:flutter_challenge_tractian/features/tree/domain/entities/company_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';

class GetAllCompaniesUsecase {
  final TreeRepository _treeRepository;

  GetAllCompaniesUsecase(this._treeRepository);

  Future<List<CompanyEntity>> call() {
    return _treeRepository.getAllCompanies();
  }
}
