import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SecureStorageService _secureStorage;

  AuthBloc(this._loginUseCase, this._secureStorage) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final result = await _loginUseCase(
        LoginParams(username: event.username, password: event.password),
      );

      await result.fold(
        (failure) async {
          emit(AuthError(failure.message));
        },
        (user) async {
          if (user.token != null) {
            await _secureStorage.saveToken(user.token!);
          }
          emit(AuthAuthenticated(user));
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      print('Logging out...');
      await _secureStorage.deleteToken();
      final token = await _secureStorage.getToken();
      print('Token after logout: $token');

      if (token == null || token.isEmpty) {
        emit(AuthUnauthenticated());
      } else {
        emit(AuthError('Failed to delete token'));
      }
    } catch (e) {
      print('Error during logout: $e');
      emit(AuthError(e.toString()));
    }
  }
}
