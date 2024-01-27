import 'package:flutter/material.dart';
import 'package:lettutor/common/providers/data_provider.dart';
import 'package:lettutor/models/course.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/footer.dart';
import '../../common/widgets/top_app_bar_content.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key, required this.courseId});

  final String courseId;

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late Course? _course;

  @override
  void initState() {
    super.initState();

    _course = null;
  }

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
              margin: const EdgeInsets.fromLTRB(10, 20, 50, 0),
              child: FutureBuilder(
                future: context.read<CourseDataProvider>().getCourseById(widget.courseId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _course = snapshot.data;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                                  blurRadius: 0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                // border and shadow
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      _course!.coverUri.toString(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_course!.title,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            _course!.description,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context).colorScheme.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                              ),
                                              child: Text(
                                                "Khám phá",
                                                style: TextStyle(
                                                    fontFamily: 'Open Sans',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context).colorScheme.onPrimary),
                                              ),
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
                        Expanded(
                          flex: 15,
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tổng quan
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                                      child: const Text("Tổng quan",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    const Row(
                                      children: [
                                        // Icon and text
                                        Icon(
                                          Icons.question_mark,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Tại sao bạn nên học khóa học này",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                                      child: Text(_course!.whyDescription,
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 14,
                                          )),
                                    ),
                                    const Row(
                                      children: [
                                        // Icon and text
                                        Icon(
                                          Icons.question_mark,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Bạn có thể làm gì",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                                      child: Text(_course!.whatDescription,
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 14,
                                          )),
                                    ),
                                  ],
                                ),
                                // Trình độ yêu cầu
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                                      child: const Text("Trình độ yêu cầu",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    Row(
                                      children: [
                                        // Icon and text
                                        const Icon(
                                          Icons.people_alt_outlined,
                                          color: Colors.indigo,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _course!.level.toString(),
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Thời lượng khóa học
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                                      child: const Text("Khối lượng",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    Row(
                                      children: [
                                        // Icon and text
                                        const Icon(
                                          Icons.book_outlined,
                                          color: Colors.indigo,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${_course!.topics.length.toString()} Chủ đề",
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                                      child: const Text("Danh sách chủ đề",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    GridView.count(
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
                                      childAspectRatio: 1 / 0.4,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      children: List.generate(
                                        _course!.topics.length,
                                        (index) => Container(
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                                  .withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text((index + 1).toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    )),
                                                Text(_course!.topics[index].name,
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    throw snapshot.error!;
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
