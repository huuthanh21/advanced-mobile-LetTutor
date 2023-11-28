import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/common/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/footer.dart';
import '../../core/providers/login_provider.dart';
import '../../models/user.dart';
import 'components/InputField.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

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
                Container(
                  width: 400,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Đăng ký",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              "Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ĐỊA CHỈ EMAIL",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                              ),
                              InputField(
                                controller: _emailFieldController,
                                hintText: 'mail@example.com',
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                              ),
                              InputField(controller: _passwordFieldController),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => register(context),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Center(
                              child: Text("ĐĂNG KÝ",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white))),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                              child: const Text("Đăng nhập ngay",
                                  style: TextStyle(color: Colors.blue)),
                              onTap: () =>
                                  context.go(context.namedLocation('login')),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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

  void register(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    bool isRegistered = loginProvider.register(User(
        email: _emailFieldController.text,
        password: _passwordFieldController.text));
    if (isRegistered) {
      // Clear the text fields
      _emailFieldController.clear();
      _passwordFieldController.clear();
      // Navigate to the login page
      context.go(context.namedLocation('login'));
    }
    return;
  }
}
