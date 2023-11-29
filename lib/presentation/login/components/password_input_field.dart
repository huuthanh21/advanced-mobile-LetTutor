import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required TextEditingController controller,
    String? hintText,
  })  : _controller = controller,
        _hintText = hintText;

  final TextEditingController _controller;
  final String? _hintText;

  @override
  Widget build(BuildContext context) {
    return PasswordField(
      controller: _controller,
      passwordConstraint: r'^.{6,}$',
      hintText: _hintText,
      border: PasswordBorder(
        border: const OutlineInputBorder(),
      ),
      errorMessage: 'Mật khẩu phải có ít nhất 6 ký tự',
    );
  }
}
