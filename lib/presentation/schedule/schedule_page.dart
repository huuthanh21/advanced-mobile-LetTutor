import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/common/converters/start_datetime_to_schedule_range.dart';
import 'package:lettutor/common/providers/data_provider.dart';
import 'package:lettutor/common/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';

import '../../common/utils/country_mapper.dart';
import '../../common/widgets/footer.dart';
import '../../core/providers/login_provider.dart';
import '../../models/booking.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late LoginProvider _loginProvider;
  late BookingDataProvider _bookingDataProvider;
  late TutorDataProvider _tutorDataProvider;
  late List<Booking> _bookings;

  @override
  void initState() {
    super.initState();

    // Providers
    _loginProvider = context.read<LoginProvider>();
    _bookingDataProvider = context.read<BookingDataProvider>();
    _tutorDataProvider = context.read<TutorDataProvider>();

    _bookings = [];
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showCancelDialog(BuildContext context, Booking booking) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hủy buổi học'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Bạn có chắc chắn muốn hủy buổi học này?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Hủy'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Xác nhận'),
                onPressed: () async {
                  // Update in provider
                  if (await _bookingDataProvider.cancelBooking(booking) == false) {
                    // show toast
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Hủy buổi học thất bại'),
                      ),
                    );
                    // Close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Hủy buổi học thành công'),
                      ),
                    );
                    Navigator.of(context).pop();
                    return;
                  }

                  // Update local state
                  setState(() {
                    _bookings.remove(booking);
                  });

                  // Close dialog
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                              'Lịch học',
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
                  const Gap(20),
                  FutureBuilder(
                      future: context.read<BookingDataProvider>().getBookingSchedule(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _bookings = snapshot.data as List<Booking>;
                          return Column(
                            children: List<Widget>.generate(
                              _bookings.length,
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
                                          DateFormat('EEE, dd MMM yy', 'vi_VN')
                                              .format(_bookings[index].dateTime),
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
                                            child: Image.network(
                                                _bookings[index].tutor.profilePictureUrl),
                                          ),
                                        ),
                                        const Gap(10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(_bookings[index].tutor.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(fontSize: 22)),
                                            Row(children: [
                                              CountryFlag.fromCountryCode(
                                                  _bookings[index].tutor.countryCode,
                                                  width: 20,
                                                  height: 20),
                                              const Gap(5),
                                              Text(
                                                CountryMapper.countryCodeToName(
                                                    _bookings[index].tutor.countryCode),
                                                style: TextStyle(color: Colors.grey.shade600),
                                              ),
                                            ]),
                                            TextButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(Icons.message_outlined),
                                                label: const Text("Nhắn tin"),
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty.resolveWith(
                                                      (states) => EdgeInsets.zero),
                                                  overlayColor: MaterialStateProperty.resolveWith(
                                                      (states) => Colors.transparent),
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
                                          padding: const EdgeInsets.all(20),
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Text and cancel button
                                                  Text(
                                                    formatDateTimeToTimeRange(
                                                        _bookings[index].dateTime),
                                                    style: const TextStyle(
                                                      fontFamily: 'Open Sans',
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  // Cancel button
                                                  TextButton.icon(
                                                      onPressed: () => showCancelDialog(
                                                          context, _bookings[index]),
                                                      icon: const Icon(
                                                          Icons.cancel_presentation_outlined,
                                                          color: Colors.red),
                                                      // red square border
                                                      style: TextButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          side: const BorderSide(
                                                            color: Colors.red,
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                      ),
                                                      label: const Text(
                                                        'Hủy',
                                                        style: TextStyle(color: Colors.red),
                                                      ))
                                                ],
                                              ),
                                              const Gap(10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(5),
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
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Icon(Icons.arrow_drop_down),
                                                              Text(
                                                                'Yêu cầu cho buổi học',
                                                                style: TextStyle(
                                                                  fontFamily: 'Open Sans',
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
                                                                fontFamily: 'Open Sans',
                                                                fontSize: 16,
                                                                color: Colors.blue,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(20),
                                                      child: const Text(
                                                          "Hiện tại không có yêu cầu cho lớp học này. Xin vui lòng viết ra bất kỳ yêu cầu nào cho giáo viên nếu có."),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Gap(20),
                                        TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color.fromRGBO(0, 113, 240, 1)
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
                            ),
                          );
                        } else if (snapshot.hasError) {
                          throw snapshot.error!;
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ),
            const Gap(40),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
