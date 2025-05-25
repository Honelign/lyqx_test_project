import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';

/// Cart item entity representing a product in the cart
class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  /// Total price of the cart item
  double get totalPrice => product.price * quantity;

  /// Creates a copy of this cart item with the given fields replaced
  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}