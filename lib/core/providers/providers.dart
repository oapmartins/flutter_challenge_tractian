import 'package:dio/dio.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dada_sources/remote/tree_data_source.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dada_sources/remote/tree_data_source_impl.dart';
import 'package:flutter_challenge_tractian/features/tree/data/repositories/tree_repository_impl.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_assets_usecase.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_locations_usecase.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/usecases/get_all_companies_usecase.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/assets_controller.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/menu_controller.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupProviders() {
  Dio dio = Dio();

  // Tree Provider
  getIt.registerSingleton<TreeDataSource>(TreeDataSourceImpl(dio));
  getIt.registerSingleton<TreeRepository>(
    TreeRepositoryImpl(
      getIt<TreeDataSource>(),
    ),
  );

  // Menu Provider
  getIt.registerFactory(() => GetAllCompaniesUsecase(getIt<TreeRepository>()));
  getIt.registerSingleton<MenuController>(MenuController(
    getIt<GetAllCompaniesUsecase>(),
  ));

  // Assets Provider
  getIt.registerFactory(() => GetAllCompaniesAssetsUsecase(getIt<TreeRepository>()));
  getIt.registerFactory(() => GetAllCompaniesLocationsUsecase(getIt<TreeRepository>()));
  getIt.registerLazySingleton<AssetsController>(
    () => AssetsController(
      getIt<GetAllCompaniesAssetsUsecase>(),
      getIt<GetAllCompaniesLocationsUsecase>(),
    ),
  );
}
