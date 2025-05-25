part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductDetailsEvent extends ProductDetailsEvent {
  final int productId;

  const LoadProductDetailsEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
