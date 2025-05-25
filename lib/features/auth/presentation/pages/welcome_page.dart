import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx_test_project/core/routes/app_router.dart';
import 'package:lyqx_test_project/core/utils/app_resources.dart';
import 'package:lyqx_test_project/core/widgets/default_sized_box.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.background),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.only(top: 350.0),
                  child: SizedBox(
                    height: 50,
                    child: SvgPicture.asset(AppAssets.logo),
                  ),
                ),
                const DefaultSizedBox.verticalSmall(),

                // Title
                Text('Fake Store', style: textTheme.displayLarge),
                const DefaultSizedBox.verticalLarge(),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(AppRouter.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.surface,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: textTheme.displaySmall?.copyWith(
                      color: colorScheme.surface,
                    ),
                  ),
                ),
                const DefaultSizedBox.verticalLarge(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
