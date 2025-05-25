import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStorageService {
  final FlutterSecureStorage _storage;
  static const String _tokenKey = 'auth_token';

  SecureStorageService() : _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    print('Saving token: $token');
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    print('Retrieved token: $token');
    return token;
  }

  Future<void> deleteToken() async {
    print('Deleting token');
    await _storage.delete(key: _tokenKey);
    final token = await _storage.read(key: _tokenKey);
    print('Token after deletion: $token');
  }
}
