import 'package:flutter/material.dart';

import 'components/register_form.dart';
import 'layouts/auth_page_layout.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPageLayout(form: RegisterForm());
  }
}
