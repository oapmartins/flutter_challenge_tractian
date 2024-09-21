import 'package:flutter_challenge_tractian/core/exceptions/server_exception.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dada_sources/remote/tree_data_source.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dtos/company_dto.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/assets_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/company_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/locations_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';

class TreeRepositoryImpl implements TreeRepository {
  final TreeDataSource dataSource;
  TreeRepositoryImpl(this.dataSource);

  @override
  Future<List<CompanyEntity>> getAllCompanies() async {
    try {
      List<CompanyDto> allCompanies = await dataSource.getAllCompanies();

      List<CompanyEntity> listAllCompanies = [];
      for (var company in allCompanies) {
        listAllCompanies.add(company.toEntity());
      }

      return listAllCompanies;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<LocationsEntity>> getAllCompaniesLocations({required String companyId}) async {
    try {
      final allLocations = await dataSource.getAllCompaniesLocations(companyId: companyId);

      List<LocationsEntity> listAllLocations = [];
      for (var location in allLocations) {
        listAllLocations.add(location.toEntity());
      }

      return listAllLocations;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<AssetsEntity>> getAllCompaniesAssets({required String companyId}) async {
    try {
      final allAssets = await dataSource.getAllCompaniesAssets(companyId: companyId);
      List<AssetsEntity> listAllAssets = [];
      for (var asset in allAssets) {
        listAllAssets.add(asset.toEntity());
      }

      return listAllAssets;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }
}
