part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductsEvent {
  final bool loadMore;

  const LoadProductsEvent({this.loadMore = false});

  @override
  List<Object?> get props => [loadMore];
}

class LoadProductDetailsEvent extends ProductsEvent {
  final int productId;

  const LoadProductDetailsEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}