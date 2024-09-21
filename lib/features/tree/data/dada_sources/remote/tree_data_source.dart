import 'package:flutter_challenge_tractian/features/tree/data/dtos/assets_dto.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dtos/company_dto.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dtos/locations_dto.dart';

abstract class TreeDataSource {
  Future<List<CompanyDto>> getAllCompanies();
  Future<List<LocationsDto>> getAllCompaniesLocations({required String companyId});
  Future<List<AssetsDto>> getAllCompaniesAssets({required String companyId});
}
