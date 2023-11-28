import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController controller,
    String? hintText,
  })  : _controller = controller,
        _hintText = hintText;

  final TextEditingController _controller;
  final String? _hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: _hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
