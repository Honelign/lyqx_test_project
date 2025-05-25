import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/wishlist_item.dart';

abstract class WishlistRepository {
  /// Gets all wishlist items
  /// 
  /// Returns [List<WishlistItem>] on success
  /// Returns [Failure] on error
  Future<Either<Failure, List<WishlistItem>>> getWishlistItems();
  
  /// Adds a product to the wishlist
  /// 
  /// Returns [List<WishlistItem>] on success
  /// Returns [Failure] on error
  Future<Either<Failure, List<WishlistItem>>> addToWishlist(Product product);
  
  /// Removes a product from the wishlist
  /// 
  /// Returns [List<WishlistItem>] on success
  /// Returns [Failure] on error
  Future<Either<Failure, List<WishlistItem>>> removeFromWishlist(int productId);
  
  /// Clears the wishlist
  /// 
  /// Returns [void] on success
  /// Returns [Failure] on error
  Future<Either<Failure, void>> clearWishlist();
}