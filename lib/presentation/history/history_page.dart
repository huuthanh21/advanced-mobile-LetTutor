import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/common/widgets/rating_bar.dart';
import 'package:provider/provider.dart';

import '../../common/converters/start_datetime_to_schedule_range.dart';
import '../../common/providers/data_provider.dart';
import '../../common/utils/country_mapper.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/top_app_bar.dart';
import '../../core/providers/login_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Providers
    var bookingDataProvider = context.read<BookingDataProvider>();
    var loginProvider = context.read<LoginProvider>();

    var user = loginProvider.user;
    var histories = bookingDataProvider.getHistoriesByUser(user);

    return Scaffold(
      appBar: TopAppBar(isLoggedIn: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                  const Gap(20),
                  Column(
                    children: List<Widget>.generate(
                      histories.length,
                      (index) => Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('EEE, dd MMM yy', 'vi_VN').format(
                                      histories[index].booking.dateTime),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
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
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(histories[index]
                                          .booking
                                          .tutor
                                          .profilePictureUrl),
                                    )),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(histories[index].booking.tutor.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 22)),
                                    Row(children: [
                                      CountryFlag.fromCountryCode(
                                          histories[index]
                                              .booking
                                              .tutor
                                              .countryCode,
                                          width: 20,
                                          height: 20),
                                      const Gap(5),
                                      Text(
                                        CountryMapper.countryCodeToName(
                                            histories[index]
                                                .booking
                                                .tutor
                                                .countryCode),
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ]),
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.message_outlined),
                                        label: const Text("Nhắn tin"),
                                        style: ButtonStyle(
                                          padding:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => EdgeInsets.zero),
                                          overlayColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      Colors.transparent),
                                        )),
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
                                  child: Text(
                                    'Thời gian bài học: ${formatDateTimeToTimeRange(histories[index].booking.dateTime)}',
                                    style: const TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const Gap(20),
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (histories[index]
                                                    .booking
                                                    .request ==
                                                null)
                                              const Text(
                                                'Không có yêu cầu cho buổi học',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16,
                                                ),
                                              )
                                            else
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Yêu cầu cho buổi học',
                                                    style: TextStyle(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const Gap(20),
                                                  Text(
                                                    histories[index]
                                                        .booking
                                                        .request!,
                                                    style: const TextStyle(
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
                                            if (histories[index].grading ==
                                                null)
                                              const Text(
                                                'Gia sư chưa có đánh giá',
                                                style: TextStyle(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 16,
                                                ),
                                              )
                                            else
                                              Column(
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
                                                          fontFamily:
                                                              'Open Sans',
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
                                                  const Gap(20),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Buổi 1: ${formatDateTimeToTimeRange(histories[index].booking.dateTime)}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const Gap(10),
                                                      const Text(
                                                        // TODO: Change to actual status
                                                        'Lesson status: Completed',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const Gap(10),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Behavior: (",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          RatingBar(
                                                              rating: histories[
                                                                      index]
                                                                  .grading!
                                                                  .behaviorRating),
                                                          const Text(
                                                            "): ",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            histories[index]
                                                                .grading!
                                                                .behaviorComment,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(10),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Listening: (",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          RatingBar(
                                                              rating: histories[
                                                                      index]
                                                                  .grading!
                                                                  .listeningRating),
                                                          const Text(
                                                            "): ",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            histories[index]
                                                                .grading!
                                                                .listeningComment,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(10),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Speaking: (",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          RatingBar(
                                                              rating: histories[
                                                                      index]
                                                                  .grading!
                                                                  .speakingRating),
                                                          const Text(
                                                            "): ",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            histories[index]
                                                                .grading!
                                                                .speakingComment,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(10),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Vocabulary: (",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          RatingBar(
                                                              rating: histories[
                                                                      index]
                                                                  .grading!
                                                                  .vocabularyRating),
                                                          const Text(
                                                            "): ",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            histories[index]
                                                                .grading!
                                                                .vocabularyComment,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Open Sans',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(10),
                                                      Text(
                                                        'Overall comment: ${histories[index].grading!.overallComment}',
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
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
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
