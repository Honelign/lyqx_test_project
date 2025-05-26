import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/snackbar_util.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget with SnackbarUtil {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: theme.colorScheme.onSurface,
          onPressed: () => context.pop(),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.goNamed(AppRouter.main);
            } else if (state is AuthError) {
              showErrorSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Welcome text
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome back! Glad\n",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: Color(0xFF1E232C),
                          ),
                        ),
                        TextSpan(
                          text: "to see you, Again!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: Color(0xFF1E232C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  LoginForm(isLoading: state is AuthLoading),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
