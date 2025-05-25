import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';

/// Wishlist item entity representing a product in the wishlist
class WishlistItem extends Equatable {
  final Product product;
  final DateTime addedAt;

  const WishlistItem({
    required this.product,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [product, addedAt];
}