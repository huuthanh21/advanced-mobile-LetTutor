import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/login_provider.dart';
import 'base_auth_form.dart';
import 'input_field.dart';
import 'login_form.dart';
import 'password_input_field.dart';

class RegisterForm extends BaseAuthForm {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailFieldController = TextEditingController();

  final TextEditingController _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Validate email field as the user types
    _emailFieldController.addListener(() {
      _formKey.currentState!.validate();
    });

    return Form(
      key: _formKey,
      child: Container(
        width: 400,
        margin: const EdgeInsets.fromLTRB(0, 50, 0, 50),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Đăng ký",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                    "Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ĐỊA CHỈ EMAIL",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    InputField(
                      controller: _emailFieldController,
                      hintText: 'mail@example.com',
                      validator: emailValidator,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MẬT KHẨU",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    PasswordInputField(
                      controller: _passwordFieldController,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    register(context);
                    return;
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                    child: Text("ĐĂNG KÝ", style: TextStyle(fontSize: 22, color: Colors.white))),
              ),
              const Center(child: Text("Hoặc tiếp tục với")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.g_translate),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Đã có tài khoản?"),
                  InkWell(
                    child: const Text("Đăng nhập ngay", style: TextStyle(color: Colors.blue)),
                    onTap: () => context.go(context.namedLocation('login')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  register(BuildContext context) async {
    final loginProvider = context.read<LoginProvider>();
    bool isRegistered =
        await loginProvider.register(_emailFieldController.text, _passwordFieldController.text);

    print(isRegistered);
    if (isRegistered) {
      // Clear the text fields
      _emailFieldController.clear();
      _passwordFieldController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công. Hãy đăng nhập.'),
        ),
      );
      // Navigate to the login page
      context.go(context.namedLocation('login'));
    }
    // Display an error message if the registration fails
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thất bại. Email đã được sử dụng. '),
        ),
      );
    }
    return;
  }
}
