import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx_test_project/core/widgets/default_sized_box.dart';
import 'package:lyqx_test_project/features/auth/presentation/widgets/custom_inputfield.dart';

import '../../../../core/utils/form_validators.dart';
import '../bloc/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  bool isLoading;
  LoginForm({super.key, this.isLoading = false});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Pre-fill with test credentials
    _usernameController.text = 'johnd';
    _passwordController.text = 'm38rmF\$';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        LoginEvent(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Enter your username',
            obscureText: false,
            controller: _usernameController,

            validator: FormValidators.validateUsername,
          ),
          const DefaultSizedBox.vertical(),

          CustomTextField(
            label: 'Enter your password',
            obscureText: _obscurePassword,
            controller: _passwordController,
            validator: FormValidators.validatePassword,
            onSuffixTapped: _togglePasswordVisibility,
            suffixIcon:
                _obscurePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
          ),

          const DefaultSizedBox.verticalLarge(),
          ElevatedButton(
            onPressed: _submitForm,
            child:
                widget.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                      'Login',
                      style: textTheme.displaySmall?.copyWith(
                        color: colorScheme.surface,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
