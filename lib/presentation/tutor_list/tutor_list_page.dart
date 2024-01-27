import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../common/providers/data_provider.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/top_app_bar.dart';
import '../../core/providers/login_provider.dart';
import '../../models/tutor.dart';
import '../../models/user.dart';
import 'components/tutor_card.dart';
import 'providers/favorite_tutors_provider.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<TutorListPage> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  late TutorDataProvider _tutorDataProvider;
  late List<Tutor> _displayedTutors;
  late FavoriteTutorsProvider _favoriteTutorsProvider;
  late BookingDataProvider _bookingDataProvider;
  late LoginProvider _loginProvider;

  final _tutorNameController = TextEditingController();
  final _focusNode = FocusNode();

  final List<String> _tutorCountryFilters = [
    "Gia sư Nước Ngoài",
    "Gia sư Việt Nam",
    "Gia sư Tiếng Anh bản ngữ"
  ];

  late List<int> _selectedTutorCountryFilters;
  final List<String> _tutorSpecializationFilters = ["Tất cả", ...Tutor.specializationList];
  int _selectedTutorSpecializationFilter = 0;

  DateTime? _selectedDate;
  final _dateController = TextEditingController();

  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    _tutorDataProvider = Provider.of<TutorDataProvider>(context, listen: false);
    _displayedTutors = [];
    _favoriteTutorsProvider = Provider.of<FavoriteTutorsProvider>(context, listen: false);
    _getData();
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _bookingDataProvider = Provider.of<BookingDataProvider>(context, listen: false);

    // Development only
    var users = List<User>.empty();
    _bookingDataProvider.generateRandomData(users, _tutorDataProvider.tutors);
    for (var booking in _bookingDataProvider.bookings) {
      _tutorDataProvider.bookTutor(booking.tutor.id, booking.dateTime);
    }

    _selectedTutorCountryFilters = [];
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _displayedTutors = getFilteredTutors());
      }
    });
  }

  void _getData() async {
    _tutorDataProvider.fetchTutors();
    _favoriteTutorsProvider.fetchFavoriteTutors();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _displayedTutors = _tutorDataProvider.tutors;
        for (var tutor in _favoriteTutorsProvider.favoriteTutorsId) {
          print(tutor);
        }
      });
    });
  }

  Future<void> _showDatePicker() async {
    final now = DateTime.now();
    final value = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (value != null) {
      setState(() {
        _selectedDate = value;
        _dateController.text = DateFormat.yMd().format(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontSize: 24, fontFamily: "Open Sans", color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "T7, 04 Thg 11 23 18:00 - 18:25 (còn 27:13:25)",
                        style:
                            TextStyle(fontSize: 18, fontFamily: "Open Sans", color: Colors.white),
                      ),
                      const Gap(20),
                      TextButton.icon(
                          onPressed: () {},
                          icon:
                              Icon(Icons.video_call, color: Theme.of(context).colorScheme.primary),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          label: Text("Vào lớp học",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary))),
                    ],
                  ),
                  FutureBuilder(
                      future: _tutorDataProvider.getTotalHours(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              "Tổng số giờ bạn đã học là ${totalHoursToFormatted(snapshot.data)}",
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: "Open Sans", color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return Text("Loading...");
                        }
                      }),
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
                  const Gap(20),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: TextField(
                          controller: _tutorNameController,
                          focusNode: _focusNode,
                          onEditingComplete: () {
                            setState(() {
                              _displayedTutors = getFilteredTutors();
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            hintText: "Nhập tên gia sư...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 500,
                        child: MultiSelectDialogField(
                          key: GlobalKey(),
                          initialValue: _selectedTutorCountryFilters,
                          title: const Text("Chọn quốc gia gia sư"),
                          buttonText: const Text(
                            "Chọn quốc gia gia sư",
                            style: TextStyle(color: Colors.grey),
                          ),
                          dialogHeight: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          cancelText: const Text("HỦY"),
                          items: _tutorCountryFilters
                              .mapIndexed((index, value) => MultiSelectItem(
                                    index,
                                    value,
                                  ))
                              .toList(),
                          onConfirm: (values) {
                            setState(() {
                              _selectedTutorCountryFilters = values.cast<int>();
                              _displayedTutors = getFilteredTutors();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  const Text("Chọn thời gian dạy kèm có lịch trống: "),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 170,
                        height: 40,
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            hintText: "Chọn một ngày",
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey.shade400,
                              size: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          onTap: _showDatePicker,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            hintText: "Giờ bắt đầu - Giờ kết thúc",
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    runSpacing: 10,
                    children: List<Widget>.generate(
                      _tutorSpecializationFilters.length,
                      (index) => ChoiceChip(
                        label: Text(_tutorSpecializationFilters[index]),
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              style: BorderStyle.none,
                            )),
                        selected: _selectedTutorSpecializationFilter == index,
                        onSelected: (selected) {
                          setState(() {
                            _selectedTutorSpecializationFilter = selected ? index : 0;
                            _displayedTutors = getFilteredTutors();
                          });
                        },
                      ),
                    ),
                  ),
                  const Gap(10),
                  TextButton(
                    onPressed: () => resetFilters(),
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
                        style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  ),
                  const Gap(20),
                  Text("Gia sư được đề xuất",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 28)),
                  const Gap(10),
                  Consumer<FavoriteTutorsProvider>(
                    builder: (context, value, child) {
                      _displayedTutors = getFilteredTutors();
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _displayedTutors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TutorCard(tutor: _displayedTutors[index]);
                        },
                      );
                    },
                  ),
                  if (_displayedTutors.isEmpty)
                    const SizedBox(
                      height: 200,
                      child: Center(
                        child:
                            Text("Xin lỗi, chúng tôi không thể tìm thấy kết quả vớI từ khoá này"),
                      ),
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

  void resetFilters() {
    setState(() {
      _selectedTutorCountryFilters.clear();
      _tutorNameController.clear();
      _selectedTutorSpecializationFilter = 0;
      _displayedTutors = _tutorDataProvider.tutors;
    });
  }

  List<Tutor> getFilteredTutors() {
    String searchText = _tutorNameController.text.toLowerCase();
    List<Tutor> filteredTutors = _tutorDataProvider.tutors
        .where((tutor) => tutor.name.toLowerCase().contains(searchText))
        .toList();

    bool foreignFilter = _selectedTutorCountryFilters.contains(0);
    bool vietnameseFilter = _selectedTutorCountryFilters.contains(1);
    bool nativeSpeakerFilter = _selectedTutorCountryFilters.contains(2);

    // If two filters are selected, there are 3 cases:
    // 1. Vietnamese and foreigner filters are selected: every tutor is shown since they are either Vietnamese or foreigner
    // 2. Vietnamese and native speaker filters are selected: show Vietnamese and native speakers
    // 3. Foreigner and native speaker filters are selected: show foreigner tutors since native speakers are already included
    if (_selectedTutorCountryFilters.length == 2) {
      if (vietnameseFilter && nativeSpeakerFilter) {
        filteredTutors = filteredTutors
            .where((tutor) => !tutor.isForeigner || tutor.isNativeEnglishSpeaker)
            .toList();
      } else if (foreignFilter && nativeSpeakerFilter) {
        filteredTutors = filteredTutors.where((tutor) => !tutor.isForeigner).toList();
      }
    }

    // If one filter is selected, there are 3 cases:
    // 1. Vietnamese filter is selected: show Vietnamese tutors
    // 2. Foreigner filter is selected: show foreigner tutors
    // 3. Native speaker filter is selected: show native speakers
    if (_selectedTutorCountryFilters.length == 1) {
      if (vietnameseFilter) {
        filteredTutors = filteredTutors.where((tutor) => !tutor.isForeigner).toList();
      } else if (foreignFilter) {
        filteredTutors = filteredTutors.where((tutor) => tutor.isForeigner).toList();
      } else if (nativeSpeakerFilter) {
        filteredTutors = filteredTutors.where((tutor) => tutor.isNativeEnglishSpeaker).toList();
      }
    }

    String selectedSpecialization = _tutorSpecializationFilters[_selectedTutorSpecializationFilter];
    if (_selectedTutorSpecializationFilter != 0) {
      filteredTutors = filteredTutors
          .where((tutor) => tutor.specializations.contains(selectedSpecialization))
          .toList();
    }

    sortTutorsByFavorite(filteredTutors);

    sortTutorsByRating(filteredTutors);

    return filteredTutors;
  }

  void sortTutorsByFavorite(List<Tutor> tutors) {
    tutors.sort((a, b) {
      bool aIsFavorite = _favoriteTutorsProvider.isFavorite(a.id);
      bool bIsFavorite = _favoriteTutorsProvider.isFavorite(b.id);

      if (aIsFavorite && !bIsFavorite) {
        return -1;
      } else if (!aIsFavorite && bIsFavorite) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  @override
  void dispose() {
    _tutorNameController.dispose();
    _focusNode.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String totalHoursToFormatted(int? hours) {
    if (hours == null) return "0";
    int totalHours = hours ~/ 60;
    int totalMinutes = hours % 60;
    return "$totalHours giờ $totalMinutes phút";
  }

  void sortTutorsByRating(List<Tutor> filteredTutors) {
    filteredTutors.sort((a, b) {
      if (a.calculatedRating > b.calculatedRating) {
        return -1;
      } else if (a.calculatedRating < b.calculatedRating) {
        return 1;
      } else {
        return 0;
      }
    });
  }
}
