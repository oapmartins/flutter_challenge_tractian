import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/company_entity.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_usecase.dart';

class MenuController {
  MenuController(this.getAllCompaniesUsecase);
  final GetAllCompaniesUsecase getAllCompaniesUsecase;

  List<CompanyEntity> _listAllCompanies = [];
  List<CompanyEntity> get companies => _listAllCompanies;

  ValueNotifier<LoadingStatus> loading = ValueNotifier(LoadingStatus.loading);

  Future<void> getCompanies() async {
    loading.value = LoadingStatus.loading;
    try {
      _listAllCompanies.clear();

      final List<CompanyEntity> getAllCompaniesSnap = await getAllCompaniesUsecase();
      _listAllCompanies = getAllCompaniesSnap;
      loading.value = LoadingStatus.loaded;
    } catch (e) {
      loading.value = LoadingStatus.error;
    }
  }
}
