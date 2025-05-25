part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {
  final List<Product>? previousProducts;
  final bool isLoadingMore;

  const ProductsLoading({
    this.previousProducts,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [previousProducts, isLoadingMore];
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final bool hasReachedMax;

  const ProductsLoaded({
    required this.products,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [products, hasReachedMax];

  ProductsLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProductDetailsLoading extends ProductsState {}

class ProductDetailsLoaded extends ProductsState {
  final Product product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}