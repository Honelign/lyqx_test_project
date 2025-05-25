import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Logs in a user with [username] and [password]
  ///
  /// Throws [ServerException] for all error codes
  Future<UserModel> login(String username, String password);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final response = await apiClient.post(
        ApiConstants.login,
        data: {'username': username, 'password': password},
      );

      return UserModel(token: response.data['token']);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.statusMessage ?? 'Failed to login',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }
}
