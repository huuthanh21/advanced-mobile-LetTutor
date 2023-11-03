import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/widgets/top_app_bar_content.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

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
                    Icons.calendar_today,
                    size: 100,
                  ),
                  // Big icon and a column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text
                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Text
                        Text(
                          'Đây là danh sách những khung giờ bạn đã đặt',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.',
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
                  for (int i = 0; i < 3; i++)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        icon:
                                            const Icon(Icons.message_outlined),
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
                                    padding: const EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text and cancel button
                                            const Text(
                                              '18:00 - 18:25',
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 22,
                                              ),
                                            ),
                                            // Cancel button
                                            TextButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons
                                                        .cancel_presentation_outlined,
                                                    color: Colors.red),
                                                // red square border
                                                style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      color: Colors.red,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                ),
                                                label: const Text(
                                                  'Hủy',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                // border bottom
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Icon(Icons
                                                            .arrow_drop_down),
                                                        Text(
                                                          'Yêu cầu cho buổi học',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Open Sans',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const Text(
                                                        'Chỉnh sửa yêu cầu',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 16,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: const Text(
                                                    "Hiện tại không có yêu cầu cho lớp học này. Xin vui lòng viết ra bất kỳ yêu cầu nào cho giáo viên nếu có."),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(0, 113, 240, 1)
                                              .withOpacity(0.9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                    ),
                                    child: const Text(
                                      'Vào buổi học',
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
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
