import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductsRepository {
  /// Gets all products
  /// Returns [List<Product>] on success
  /// Returns [Failure] on error
  Future<Either<Failure, List<Product>>> getProducts({int? limit, int? offset});
  
  /// Gets a product by ID
  /// Returns [Product] on success
  /// Returns [Failure] on error
  Future<Either<Failure, Product>> getProductById(int id);
  
  /// Gets all product categories
  /// Returns [List<String>] on success
  /// Returns [Failure] on error
  Future<Either<Failure, List<String>>> getCategories();
}