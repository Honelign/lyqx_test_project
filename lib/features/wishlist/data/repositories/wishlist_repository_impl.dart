import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../../domain/entities/wishlist_item.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';
import '../models/wishlist_item_model.dart';

@Injectable(as: WishlistRepository)
class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;

  WishlistRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<WishlistItem>>> getWishlistItems() async {
    try {
      final items = await localDataSource.getWishlistItems();
      return Right(items);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WishlistItem>>> addToWishlist(Product product) async {
    try {
      // Get current items
      final currentItems = await localDataSource.getWishlistItems();
      
      // Check if product already exists
      final exists = currentItems.any((item) => 
          item.product.id == product.id);
      
      if (!exists) {
        // Add new item
        final newItem = WishlistItemModel(
          product: product,
          addedAt: DateTime.now(),
        );
        
        final updatedItems = List<WishlistItemModel>.from(currentItems)..add(newItem);
        await localDataSource.saveWishlistItems(updatedItems);
        return Right(updatedItems);
      }
      
      // Return current items if product already exists
      return Right(currentItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WishlistItem>>> removeFromWishlist(int productId) async {
    try {
      // Get current items
      final currentItems = await localDataSource.getWishlistItems();
      
      // Remove item
      final updatedItems = currentItems
          .where((item) => item.product.id != productId)
          .toList();
      
      await localDataSource.saveWishlistItems(updatedItems);
      return Right(updatedItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearWishlist() async {
    try {
      await localDataSource.saveWishlistItems([]);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}