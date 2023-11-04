import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/common/widgets/footer.dart';

import '../../common/widgets/top_app_bar_content.dart';

class TutorDetailPage extends StatelessWidget {
  const TutorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: TopAppBarContent(isLoggedIn: true),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              const SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Icon(Icons.person, size: 100)),
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
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 500,
                            child: Text(
                              "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text(
                                  "Đánh giá",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 150,
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.report_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text(
                                  "Đánh giá",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )
                              ],
                            ),
                          ])
                        ],
                      ),
                      Container(
                        width: 500,
                        height: 300,
                        color: Colors.grey,
                        child: const Center(child: Text("Video player")),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text("Học vấn",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text("BA")),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Ngôn ngữ",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 10,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text("English",
                                            style: TextStyle(
                                                color: Colors.grey.shade800)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Chuyên ngành",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      for (int i = 0; i < 10; i++)
                                        TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text("IELTS",
                                              style: TextStyle(
                                                  color: Colors.grey.shade800)),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Khóa học tham khảo",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                              "Basic Conversation Topics: "),
                                          InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                "Tìm hiểu",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                              "Basic Conversation Topics: "),
                                          InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                "Tìm hiểu",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Người khác đánh giá",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Row(
                                        children: [
                                          const SizedBox(
                                              width: 50,
                                              height: 50,
                                              child:
                                                  Icon(Icons.person, size: 50)),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Nguyễn Văn A",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              fontSize: 14)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("9 giờ trước",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontSize: 13)),
                                                ],
                                              ),
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                "good",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 15,
                          child: Container(
                            color: Colors.grey,
                            height: 500,
                            child: const Center(child: Text("Calendar")),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
