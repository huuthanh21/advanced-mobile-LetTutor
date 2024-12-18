import 'dart:developer';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';

import '../../common/providers/data_provider.dart';
import '../../common/utils/country_mapper.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/rating_bar.dart';
import '../../common/widgets/top_app_bar.dart';
import '../../core/api/api_service.dart';
import '../../models/tutor.dart';
import '../tutor_list/providers/favorite_tutors_provider.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  late final LoginProvider _loginProvider = context.read<LoginProvider>();
  late final TutorDataProvider _tutorDataProvider = context.read<TutorDataProvider>();
  late final BookingDataProvider _bookingsProvider = context.read<BookingDataProvider>();

  late VideoPlayerController _videoController;
  late Tutor? _tutor;

  DateTime? _selectedDate;
  List<Schedule> _schedules = [];
  List<Schedule> _displayedSchedules = [];
  final TextEditingController _dateController = TextEditingController();

  void _init() {
    _initVideoPlayer();

    var now = DateTime.now();
    _selectedDate = now;
    _dateController.text = DateFormat.yMd().format(now);
    _schedules = _tutor!.schedules.where((schedule) => schedule.dateTime.isAfter(now)).toList();
    _updateDisplayedSchedules();
  }

  @override
  void initState() {
    super.initState();

    _tutor = null;
    _selectedDate = null;
  }

  void _updateDisplayedSchedules() {
    _displayedSchedules = _schedules
        .where((schedule) =>
            schedule.dateTime.day == _selectedDate!.day &&
            schedule.dateTime.month == _selectedDate!.month &&
            schedule.dateTime.year == _selectedDate!.year)
        .toList();
  }

  void _initVideoPlayer() {
    _videoController = VideoPlayerController.networkUrl(_tutor!.videoUrl);
    _videoController.initialize().then((value) {
      if (!_videoController.value.isInitialized) {
        log("Video player failed to initialize");
        return;
      }
    }).catchError((e) {
      log("Video player failed to initialize: $e");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Future<void> _showDatePicker() async {
    final now = DateTime.now();
    final value = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 7)),
    );
    if (value != null) {
      setState(() {
        _selectedDate = value;
        _dateController.text = DateFormat.yMd().format(value);
        _updateDisplayedSchedules();
      });
    }
  }

  Future<bool> bookSchedule(Schedule schedule) async {
    return await ApiService().bookSchedule(schedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(isLoggedIn: true),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _tutorDataProvider.getTutorById(widget.tutorId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              log("co data r");
              _tutor = snapshot.data as Tutor;
              _init();
              return _buildBody();
            } else if (snapshot.hasError) {
              throw snapshot.error!;
              log(snapshot.error.toString());
              return const Center(child: Text("Đã có lỗi xảy ra"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
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
                              child: Image.network(_tutor!.profilePictureUrl),
                            ),
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_tutor!.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 22)),
                              Row(children: [
                                CountryFlag.fromCountryCode(_tutor!.countryCode,
                                    width: 20, height: 20),
                                const Gap(5),
                                Text(
                                  CountryMapper.countryCodeToName(_tutor!.countryCode),
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ]),
                              if (_tutor!.calculatedRating == 0)
                                Text(
                                  "Không có đánh giá",
                                  style: TextStyle(
                                      color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                                )
                              else
                                Row(
                                  children: [
                                    RatingBar(rating: _tutor!.calculatedRating.round()),
                                    Text(
                                      "(${_tutor!.reviews.length})",
                                      style: TextStyle(
                                          color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                      const Gap(20),
                      SizedBox(
                        width: 500,
                        child: Text(
                          _tutor!.description,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ),
                      const Gap(20),
                      Row(children: [
                        Column(
                          children: [
                            if (_tutor!.isFavorite == true)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    var favoriteTutorsProvider =
                                        context.read<FavoriteTutorsProvider>();
                                    favoriteTutorsProvider.removeFavoriteTutor(_tutor!.id);
                                    _tutor!.isFavorite = false;
                                  });
                                },
                                icon: const Icon(Icons.favorite, color: Colors.red),
                              )
                            else
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    var favoriteTutorsProvider =
                                        context.read<FavoriteTutorsProvider>();
                                    favoriteTutorsProvider.addFavoriteTutor(_tutor!.id);
                                    _tutor!.isFavorite = true;
                                  });
                                },
                                icon: Icon(Icons.favorite_border_outlined,
                                    color: Theme.of(context).colorScheme.primary),
                              ),
                            Text(
                              "Yêu thích",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ),
                        const Gap(150),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.report_outlined,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Text(
                              "Đánh giá",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ),
                      ])
                    ],
                  ),
                  // Video player
                  Container(
                    width: 500,
                    height: 300,
                    color: Colors.grey,
                    child: JkVideoControlPanel(
                      _videoController,
                    ),
                  ),
                ],
              ),
              const Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Học vấn
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Học vấn", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(_tutor!.education)),
                          ],
                        ),
                        const Gap(30),
                        // Ngôn ngữ
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Ngôn ngữ", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 10,
                                children: List<Widget>.generate(
                                  _tutor!.languages.length,
                                  (index) => Chip(
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    side: BorderSide.none,
                                    color: MaterialStateColor.resolveWith((_) =>
                                        Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                                    label: Text(
                                      _tutor!.languages[index],
                                      style:
                                          TextStyle(color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(30),
                        // Chuyên ngành
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Chuyên ngành", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 10,
                                runSpacing: 10,
                                children: List<Widget>.generate(
                                  _tutor!.specializations.length,
                                  (index) => Chip(
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    side: BorderSide.none,
                                    color: MaterialStateColor.resolveWith((_) =>
                                        Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                                    label: Text(
                                      _tutor!.specializations[index],
                                      style:
                                          TextStyle(color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(30),
                        // Khóa học tham khảo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Khóa học tham khảo", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  _tutor!.courses.length,
                                  (index) {
                                    return Row(
                                      children: [
                                        Text(_tutor!.courses[index].title),
                                        const Gap(10),
                                        InkWell(
                                            onTap: () {},
                                            child: const Text(
                                              "Tìm hiểu",
                                              style: TextStyle(color: Colors.blue),
                                            ))
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(30),
                        // Sở thích
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Sở thích", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(_tutor!.hobbies)),
                          ],
                        ),
                        const Gap(30),
                        // Kinh nghiệm giảng dạy
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Kinh nghiệm giảng dạy", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(_tutor!.experience)),
                          ],
                        ),
                        const Gap(30),
                        // Đánh giá
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Người khác đánh giá", style: TextStyle(fontSize: 16)),
                            const Gap(10),
                            if (_tutor!.reviews.isEmpty)
                              Text(
                                "Không có đánh giá",
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                              )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List<Widget>.generate(
                                  _tutor!.reviews.length,
                                  (index) => Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Image.network(
                                              _tutor!.reviews[index].authorAvatar.toString()),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(_tutor!.reviews[index].authorName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .copyWith(fontSize: 14)),
                                              const Gap(10),
                                              Text(
                                                  DateFormat.yMd()
                                                      .format(_tutor!.reviews[index].date),
                                                  style: TextStyle(
                                                      color: Colors.grey.shade600, fontSize: 13)),
                                            ],
                                          ),
                                          RatingBar(rating: _tutor!.reviews[index].rating),
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              _tutor!.reviews[index].content,
                                              softWrap: true,
                                              maxLines: 3,
                                              style: const TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          const Gap(10),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // header
                        const Gap(10),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            hintText: "Chọn một ngày",
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey.shade400,
                              size: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          onTap: _showDatePicker,
                        ),
                        const Gap(20),
                        Column(
                          children: List.generate(
                            _displayedSchedules.length,
                            (index) => Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                          DateFormat.Hm()
                                              .format(_displayedSchedules[index].dateTime),
                                          style: TextStyle(
                                              color: _displayedSchedules[index].isBooked
                                                  ? Colors.grey.shade600
                                                  : Colors.black,
                                              fontSize: 16),
                                        )),
                                    const Gap(10),
                                    if (_displayedSchedules[index].isBooked)
                                      const Text("Đã đặt", style: TextStyle(color: Colors.grey))
                                    else
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (await bookSchedule(_displayedSchedules[index]) ==
                                              false) {
                                            // show toast
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Đặt lịch không thành công. Đã có lỗi xảy ra"),
                                              ),
                                            );
                                            return;
                                          }
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Đặt lịch thành công"),
                                            ),
                                          );
                                          setState(() {
                                            _displayedSchedules[index].isBooked = true;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                        ),
                                        child: const Text("Đặt",
                                            style: TextStyle(color: Colors.white)),
                                      )
                                  ],
                                ),
                                const Gap(10),
                              ],
                            ),
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
        const Footer(),
      ],
    );
  }
}
