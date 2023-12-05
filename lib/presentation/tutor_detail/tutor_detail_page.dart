import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/data_provider.dart';
import '../../common/utils/country_mapper.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/rating_bar.dart';
import '../../common/widgets/top_app_bar_content.dart';

class TutorDetailPage extends StatelessWidget {
  const TutorDetailPage({super.key, required this.tutorId});

  final String tutorId;

  @override
  Widget build(BuildContext context) {
    final tutor = context.read<TutorDataProvider>().getTutorById(tutorId);

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
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(tutor.profilePictureUrl),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tutor.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 22)),
                                  Row(children: [
                                    CountryFlag.fromCountryCode(
                                        tutor.countryCode,
                                        width: 20,
                                        height: 20),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      CountryMapper.countryCodeToName(
                                          tutor.countryCode),
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  ]),
                                  if (tutor.reviews.isEmpty)
                                    Text(
                                      "Không có đánh giá",
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontStyle: FontStyle.italic),
                                    )
                                  else
                                    Row(
                                      children: [
                                        RatingBar(rating: tutor.rating),
                                        Text(
                                          "(${tutor.reviews.length})",
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 500,
                            child: Text(
                              tutor.description,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Học vấn",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(tutor.education)),
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
                                    children: List<Widget>.generate(
                                      tutor.languages.length,
                                      (index) => Chip(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        side: BorderSide.none,
                                        color: MaterialStateColor.resolveWith(
                                            (_) => Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1)),
                                        label: Text(
                                          tutor.languages[index],
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                    ),
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
                                    children: List<Widget>.generate(
                                      tutor.specializations.length,
                                      (index) => Chip(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        side: BorderSide.none,
                                        color: MaterialStateColor.resolveWith(
                                            (_) => Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1)),
                                        label: Text(
                                          tutor.specializations[index],
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                    ),
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
