// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/cart/presentation/bloc/cart_bloc.dart' as _i517;
import '../../features/products/data/datasources/products_remote_data_source.dart'
    as _i646;
import '../../features/products/data/repositories/products_repository_impl.dart'
    as _i1045;
import '../../features/products/domain/repositories/products_repository.dart'
    as _i27;
import '../../features/products/domain/usecases/get_product_by_id_usecase.dart'
    as _i341;
import '../../features/products/domain/usecases/get_products_usecase.dart'
    as _i15;
import '../../features/products/presentation/bloc/product_details_bloc.dart'
    as _i663;
import '../../features/products/presentation/bloc/products_bloc.dart' as _i975;
import '../../features/wishlist/data/datasources/wishlist_local_data_source.dart'
    as _i1048;
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart'
    as _i919;
import '../../features/wishlist/domain/repositories/wishlist_repository.dart'
    as _i4;
import '../../features/wishlist/domain/usecases/add_to_wishlist_usecase.dart'
    as _i74;
import '../../features/wishlist/domain/usecases/get_wishlist_items_usecase.dart'
    as _i361;
import '../../features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart'
    as _i120;
import '../../features/wishlist/presentation/bloc/wishlist_bloc.dart' as _i86;
import '../api/api_client.dart' as _i277;
import '../routes/app_router.dart' as _i629;
import '../services/secure_storage_service.dart' as _i535;
import '../utils/storage_service.dart' as _i290;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i290.StorageService>(() => _i290.StorageService());
  gh.factory<_i517.CartBloc>(() => _i517.CartBloc());
  gh.singleton<_i277.ApiClient>(() => _i277.ApiClient());
  gh.singleton<_i629.AppRouter>(() => _i629.AppRouter());
  gh.singleton<_i535.SecureStorageService>(() => _i535.SecureStorageService());
  gh.factory<_i646.ProductsRemoteDataSource>(
    () => _i646.ProductsRemoteDataSourceImpl(gh<_i277.ApiClient>()),
  );
  gh.factory<_i107.AuthRemoteDataSource>(
    () => _i107.AuthRemoteDataSourceImpl(gh<_i277.ApiClient>()),
  );
  gh.factory<_i27.ProductsRepository>(
    () => _i1045.ProductsRepositoryImpl(gh<_i646.ProductsRemoteDataSource>()),
  );
  gh.factory<_i787.AuthRepository>(
    () => _i153.AuthRepositoryImpl(gh<_i107.AuthRemoteDataSource>()),
  );
  gh.lazySingleton<_i1048.WishlistLocalDataSource>(
    () => _i1048.WishlistLocalDataSourceImpl(
      sharedPreferences: gh<_i460.SharedPreferences>(),
    ),
  );
  gh.factory<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i4.WishlistRepository>(
    () => _i919.WishlistRepositoryImpl(gh<_i1048.WishlistLocalDataSource>()),
  );
  gh.factory<_i361.GetWishlistItemsUseCase>(
    () => _i361.GetWishlistItemsUseCase(gh<_i4.WishlistRepository>()),
  );
  gh.factory<_i120.RemoveFromWishlistUseCase>(
    () => _i120.RemoveFromWishlistUseCase(gh<_i4.WishlistRepository>()),
  );
  gh.factory<_i74.AddToWishlistUseCase>(
    () => _i74.AddToWishlistUseCase(gh<_i4.WishlistRepository>()),
  );
  gh.factory<_i341.GetProductByIdUseCase>(
    () => _i341.GetProductByIdUseCase(gh<_i27.ProductsRepository>()),
  );
  gh.factory<_i15.GetProductsUseCase>(
    () => _i15.GetProductsUseCase(gh<_i27.ProductsRepository>()),
  );
  gh.factory<_i663.ProductDetailsBloc>(
    () => _i663.ProductDetailsBloc(gh<_i341.GetProductByIdUseCase>()),
  );
  gh.factory<_i975.ProductsBloc>(
    () => _i975.ProductsBloc(
      gh<_i15.GetProductsUseCase>(),
      gh<_i341.GetProductByIdUseCase>(),
    ),
  );
  gh.factory<_i797.AuthBloc>(
    () => _i797.AuthBloc(
      gh<_i188.LoginUseCase>(),
      gh<_i535.SecureStorageService>(),
    ),
  );
  gh.factory<_i86.WishlistBloc>(
    () => _i86.WishlistBloc(
      gh<_i361.GetWishlistItemsUseCase>(),
      gh<_i74.AddToWishlistUseCase>(),
      gh<_i120.RemoveFromWishlistUseCase>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
