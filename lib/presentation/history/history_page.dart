import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/widgets/top_app_bar_content.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: TopAppBarContent(isLoggedIn: true),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  // Icon
                  Icon(
                    Icons.call,
                    color: Color.fromRGBO(0, 113, 240, 1),
                    size: 100,
                  ),
                  // Big icon and a column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text
                        Text(
                          'Lịch sử các buổi học',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Text
                        Text(
                          'Đây là danh sách các bài học bạn đã tham gia',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Bạn có thể xem lại thông tin chi tiết về các buổi học đã tham gia đã tham gia',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fri, 17 Sep 22',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '1 buổi học',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Icon(Icons.person)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nguyễn Văn A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 22)),
                                    Row(children: [
                                      SvgPicture.asset(
                                        "images/vietnam.svg",
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Việt Nam",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ]),
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.message_outlined),
                                      label: const Text("Nhắn tin"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 500,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  color: Colors.white,
                                  child: const Text(
                                    'Thời gian bài học: 06:30 - 06:55',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 500,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Không có yêu cầu cho buổi học',
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Gia sư chưa có đánh giá',
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                'Đánh giá',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                'Báo cáo',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fri, 17 Sep 22',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '1 buổi học',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Icon(Icons.person)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nguyễn Văn A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 22)),
                                    Row(children: [
                                      SvgPicture.asset(
                                        "images/vietnam.svg",
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Việt Nam",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ]),
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.message_outlined),
                                      label: const Text("Nhắn tin"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 500,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  color: Colors.white,
                                  child: const Text(
                                    'Thời gian bài học: 06:30 - 06:55',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 500,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // text and drop down icon
                                                Text(
                                                  'Yêu cầu cho buổi học',
                                                  style: TextStyle(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Thầy nói hơi nhỏ',
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // text and drop down icon
                                                Text(
                                                  'Đánh giá từ gia sư',
                                                  style: TextStyle(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Buổi 1: 00:00 - 00:25',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Lesson status: Completed',
                                                  style: TextStyle(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Behavior: (",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 5;
                                                            i++)
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      "): ",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Hay",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Listening: (",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 5;
                                                            i++)
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      "): ",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Hay",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Speaking: (",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 5;
                                                            i++)
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      "): ",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Hay",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Vocabulary: (",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i < 5;
                                                            i++)
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      "): ",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Hay",
                                                      style: TextStyle(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'Overall comment: Good',
                                                  style: TextStyle(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                'Đánh giá',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                'Báo cáo',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
