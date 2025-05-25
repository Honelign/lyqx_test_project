import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test_project/core/di/injection.dart';
import 'package:lyqx_test_project/core/routes/app_router.dart';
import 'package:lyqx_test_project/core/services/secure_storage_service.dart';
import 'package:lyqx_test_project/core/utils/app_resources.dart';
import 'package:lyqx_test_project/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    print('Checking auth status...');
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Show splash for 2 seconds
    if (!mounted) return;

    final token = await getIt<SecureStorageService>().getToken();
    print('Token check result: $token');
    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      print('Token found, navigating to main page');
      context.goNamed(AppRouter.main);
    } else {
      print('No token found, navigating to welcome page');
      context.goNamed(AppRouter.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50, child: SvgPicture.asset(AppAssets.logo)),

            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
