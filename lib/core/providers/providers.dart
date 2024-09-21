import 'package:dio/dio.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dada_sources/remote/tree_data_source.dart';
import 'package:flutter_challenge_tractian/features/tree/data/dada_sources/remote/tree_data_source_impl.dart';
import 'package:flutter_challenge_tractian/features/tree/data/repositories/tree_repository_impl.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/repositories/tree_repository.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/assets_controller.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/menu_controller.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupProviders() {
  Dio dio = Dio();

  // Menu Provider
  getIt.registerSingleton<TreeDataSource>(TreeDataSourceImpl(dio));
  getIt.registerSingleton<TreeRepository>(
    TreeRepositoryImpl(
      getIt<TreeDataSource>(),
    ),
  );
  getIt.registerSingleton<MenuController>(MenuController(
    getIt<TreeRepository>(),
  ));

  getIt.registerLazySingleton<AssetsController>(() => AssetsController(GetIt.I<TreeRepository>()));
}
