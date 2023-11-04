import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/top_app_bar_content.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Icon
                      const Icon(
                        Icons.school,
                        size: 100,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // Big icon and a column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text
                          const Text(
                            'Khám phá các khóa học',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tìm kiếm khóa học',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'LiveTutor đã xây dựng nên các khóa học của các lĩnh vực trong cuộc sống chất lượng, bài bản và khoa học nhất cho những người đang có nhu cầu trau dồi thêm kiến thức về các lĩnh vực.',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            hintText: "Chọn cấp độ",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            hintText: "Chọn danh mục",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            hintText: "Sắp xếp theo độ khó",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TabBar(tabs: [
                      Tab(text: 'Khoá học'),
                      Tab(text: 'Ebook'),
                      Tab(text: 'Interactive E-book'),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'English for Traveling',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 30,
                      children: [
                        for (int i = 0; i < 5; i++)
                          InkWell(
                            onTap: () =>
                                context.push(context.namedLocation('course')),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.5),
                                    blurRadius: 0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 286,
                                  height: 370,
                                  // border and shadow
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "images/course_photo.png",
                                        width: 286,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 24, 24, 10),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Life in the Internet Age",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Let's discuss how technology is changing the way we live",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Intermediate • 9  Lessons",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
