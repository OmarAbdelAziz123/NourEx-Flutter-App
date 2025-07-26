import 'package:get_it/get_it.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/features/addresses/data/api_services/api_services.dart';
import 'package:nourex/features/addresses/data/repos/repos.dart';
import 'package:nourex/features/auth/data/api_services/api_services.dart';
import 'package:nourex/features/auth/data/repos/repos.dart';
import 'package:nourex/features/categories/data/api_services/api_services.dart';
import 'package:nourex/features/categories/data/repos/repos.dart';
import 'package:nourex/features/products/data/api_services/api_services.dart';
import 'package:nourex/features/products/data/repos/repos.dart';
import 'package:nourex/features/profile/data/api_services/api_services.dart';
import 'package:nourex/features/profile/data/repos/repos.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  /// Shared DI
  /// Dio
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  /// User DI
  /// ApiServices
  getIt.registerLazySingleton<AuthApiServices>(() => AuthApiServices(getIt()));
  getIt.registerLazySingleton<ProfileApiServices>(() => ProfileApiServices(getIt()));
  getIt.registerLazySingleton<CategoriesApiServices>(() => CategoriesApiServices(getIt()));
  getIt.registerLazySingleton<AddressesApiServices>(() => AddressesApiServices(getIt()));
  getIt.registerLazySingleton<ProductsApiServices>(() => ProductsApiServices(getIt()));


  /// Repos
  getIt.registerLazySingleton<AuthRepos>(() => AuthRepos(getIt()));
  getIt.registerLazySingleton<ProfileRepos>(() => ProfileRepos(getIt()));
  getIt.registerLazySingleton<CategoriesRepos>(() => CategoriesRepos(getIt()));
  getIt.registerLazySingleton<AddressesRepos>(() => AddressesRepos(getIt()));
  getIt.registerLazySingleton<ProductsRepos>(() => ProductsRepos(getIt()));
}