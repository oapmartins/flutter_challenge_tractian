import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/company_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';

abstract class TreeRepository {
  Future<List<CompanyEntity>> getAllCompanies();
  Future<List<LocationsEntity>> getAllCompaniesLocations({required String companyId});
  Future<List<AssetsEntity>> getAllCompaniesAssets({required String companyId});
}
