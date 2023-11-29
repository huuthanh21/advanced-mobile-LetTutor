import 'package:flutter/material.dart';

import 'components/login_form.dart';
import 'layouts/auth_page_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPageLayout(form: LoginForm());
  }
}
