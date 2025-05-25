import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;

  static const int _pageSize = 10;
  int _currentPage = 0;

  ProductsBloc(this._getProductsUseCase, this._getProductByIdUseCase)
    : super(ProductsInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    // If loading more, keep the current products in the state
    final currentState = state;
    List<Product>? oldProducts;
    if (event.loadMore && currentState is ProductsLoaded) {
      oldProducts = currentState.products;
      emit(ProductsLoading(previousProducts: oldProducts, isLoadingMore: true));
    } else {
      _currentPage = 0;
      emit(const ProductsLoading());
    }

    final limit = _pageSize;
    final offset = event.loadMore ? _currentPage * _pageSize : 0;

    final result = await _getProductsUseCase(
      GetProductsParams(limit: limit, offset: offset),
    );

    emit(
      result.fold((failure) => ProductsError(failure.message), (products) {
        _currentPage++;

        if (event.loadMore && oldProducts != null) {
          final allProducts = List<Product>.from(oldProducts)..addAll(products);
          return ProductsLoaded(
            products: allProducts,
            hasReachedMax: products.length < _pageSize,
          );
        } else {
          return ProductsLoaded(
            products: products,
            hasReachedMax: products.length < _pageSize,
          );
        }
      }),
    );
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetailsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductDetailsLoading());

    final result = await _getProductByIdUseCase(
      GetProductByIdParams(id: event.productId),
    );

    emit(
      result.fold(
        (failure) => ProductsError(failure.message),
        (product) => ProductDetailsLoaded(product),
      ),
    );
  }
}
