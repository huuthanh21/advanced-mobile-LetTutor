import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController controller,
    String? hintText,
    String? Function(String?)? validator,
  })  : _controller = controller,
        _hintText = hintText,
        _validator = validator;

  final TextEditingController _controller;
  final String? _hintText;
  final String? Function(String?)? _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: _hintText,
        border: const OutlineInputBorder(),
      ),
      validator: _validator,
    );
  }
}
