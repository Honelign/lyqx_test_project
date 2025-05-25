import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  /// Gets all products
  /// Throws [ServerException] for all error codes
  Future<List<ProductModel>> getProducts({int? limit, int? offset});

  /// Gets a product by ID
  /// Throws [ServerException] for all error codes
  Future<ProductModel> getProductById(int id);

  /// Gets all product categories
  /// Throws [ServerException] for all error codes
  Future<List<String>> getCategories();
}

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiClient apiClient;

  ProductsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProductModel>> getProducts({int? limit, int? offset}) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (limit != null) {
        queryParams['limit'] = limit;
      }

      final response = await apiClient.get(
        ApiConstants.products,
        queryParameters: queryParams,
      );

      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        e.response?.statusMessage ?? 'Failed to get products',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await apiClient.get('${ApiConstants.products}/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.statusMessage ?? 'Failed to get product',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await apiClient.get(ApiConstants.categories);
      return (response.data as List).map((item) => item.toString()).toList();
    } on DioException catch (e) {
      throw ServerException(
        e.response?.statusMessage ?? 'Failed to get categories',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }
}
