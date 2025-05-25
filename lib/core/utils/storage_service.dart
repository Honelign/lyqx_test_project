import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveUserToken(String token) async {
    await _secureStorage.write(key: 'user_token', value: token);
  }

  Future<void> deleteUserToken() async {
    await _secureStorage.delete(key: 'user_token');
  }
}
