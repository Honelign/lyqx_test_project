part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded(this.items);

  /// Total price of all items in the cart
  double get totalPrice => items.fold(
        0,
        (total, item) => total + item.totalPrice,
      );

  /// Total number of items in the cart
  int get totalItems => items.fold(
        0,
        (total, item) => total + item.quantity,
      );

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}