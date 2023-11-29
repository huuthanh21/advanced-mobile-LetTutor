import 'package:flutter/material.dart';

import '../../../common/widgets/footer.dart';
import '../../../common/widgets/top_app_bar.dart';
import '../components/base_auth_form.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({super.key, required BaseAuthForm form}) : _form = form;

  final BaseAuthForm _form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _form,
                Flexible(
                  child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 804, maxWidth: 868),
                      child: Image.asset(
                        'assets/images/login_splash.png',
                        fit: BoxFit.scaleDown,
                      )),
                ),
              ],
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Email không được để trống";
    }

    // Regular expression for a simple email validation
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );

    if (!emailRegex.hasMatch(email)) {
      return "Email không hợp lệ";
    }
    return null;
  }
}
