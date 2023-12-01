import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/data_provider.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/top_app_bar.dart';
import '../../models/tutor.dart';
import 'components/tutor_card.dart';

class TutorListPage extends StatelessWidget {
  const TutorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorDataProvider = Provider.of<TutorDataProvider>(context);

    return Scaffold(
      appBar: TopAppBar(isLoggedIn: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Buổi học sắp diễn ra",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Open Sans",
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "T7, 04 Thg 11 23 18:00 - 18:25 (còn 27:13:25)",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.video_call,
                            color: Theme.of(context).colorScheme.primary),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        label: Text("Vào lớp học",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                    ],
                  ),
                  const Text(
                    "Tổng số giờ bạn đã học là 514 giờ 35 phút",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Open Sans",
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tìm kiếm gia sư",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 33,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            hintText: "Nhập tên gia sư",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                            hintText: "Chọn quốc gia gia sư",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Chọn thời gian dạy kèm có lịch trống: "),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            hintText: "Nhập tên gia sư",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
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
                            hintText: "Chọn quốc gia gia sư",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("Tất cả",
                            style: TextStyle(color: Colors.grey.shade800)),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("ABC",
                            style: TextStyle(color: Colors.grey.shade800)),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("CDE",
                            style: TextStyle(color: Colors.grey.shade800)),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("FGH",
                            style: TextStyle(color: Colors.grey.shade800)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text("Đặt lại bộ tìm kiếm",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Gia sư được đề xuất",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 28)),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    scrollDirection: Axis.vertical,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children: [
                      for (Tutor tutor in tutorDataProvider.tutors)
                        TutorCard(tutor: tutor),
                    ],
                  )
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
