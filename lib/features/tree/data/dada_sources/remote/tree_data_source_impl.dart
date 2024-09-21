// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_challenge_tractian/core/exceptions/server_exception.dart';

import 'package:flutter_challenge_tractian/core/network/config_api_url.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dada_sources/remote/tree_data_source.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dtos/assets_dto.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dtos/company_dto.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dtos/locations_dto.dart';

class TreeDataSourceImpl extends TreeDataSource {
  final Dio dio;
  TreeDataSourceImpl(this.dio);

  @override
  Future<List<CompanyDto>> getAllCompanies() async {
    try {
      final response = await dio.get('${ConfigApiUrl.API_TRACTRIAN}/companies');

      List<CompanyDto> listCompanyDto = [];
      response.data.forEach((company) {
        listCompanyDto.add(CompanyDto.fromJson(company));
      });

      return listCompanyDto;
    } catch (e) {
      throw ServerException(message: 'Erro ao buscar empresas');
    }
  }

  @override
  Future<List<AssetsDto>> getAllCompaniesAssets({required String companyId}) async {
    try {
      final response = await dio.get('${ConfigApiUrl.API_TRACTRIAN}/companies/$companyId/assets');

      List<AssetsDto> listAssetsDto = [];
      response.data.forEach((assets) {
        listAssetsDto.add(AssetsDto.fromJson(assets));
      });

      return listAssetsDto;
    } catch (e) {
      throw ServerException(message: 'Erro ao buscar assets');
    }
  }

  @override
  Future<List<LocationsDto>> getAllCompaniesLocations({required String companyId}) async {
    try {
      final response = await dio.get('${ConfigApiUrl.API_TRACTRIAN}/companies/$companyId/locations');
      List<LocationsDto> listLocationsDto = [];
      response.data.forEach((locations) {
        listLocationsDto.add(LocationsDto.fromJson(locations));
      });

      return listLocationsDto;
    } catch (e) {
      throw ServerException(message: 'Erro ao buscar locations');
    }
  }
}
