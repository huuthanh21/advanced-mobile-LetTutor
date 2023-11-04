import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Text("Chính sách",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text("Điều khoản",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text("Liên hệ",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text("Hướng dẫn",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text("Đăng ký làm gia sư",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const Text(
                    "© 2021 - Bản quyền của LetTutor. Tất cả các quyền được bảo lưu.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: const Column(
              children: [
                Text("Công ty TNHH LetTutor Việt Nam (MST: 0317003289)",
                    style: TextStyle(fontFamily: 'Open Sans', fontSize: 18)),
                Text(
                    "Trụ sở chính: 9 Đường Số 3, KDC Cityland Park Hills, Phường 10, Quận Gò Vấp, Thành phố Hồ Chí Minh.",
                    style: TextStyle(fontFamily: 'Open Sans', fontSize: 18)),
                Text("Điện thoại: 0945 337 337.Email: hello@lettutor.com",
                    style: TextStyle(fontFamily: 'Open Sans', fontSize: 18)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
