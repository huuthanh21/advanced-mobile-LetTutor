import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../common/providers/data_provider.dart';
import '../../common/widgets/footer.dart';
import '../../common/widgets/top_app_bar.dart';
import '../../models/tutor.dart';
import 'components/tutor_card.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<TutorListPage> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  late TutorDataProvider _tutorDataProvider;
  late List<Tutor> _displayedTutors;

  final _tutorNameController = TextEditingController();
  final _focusNode = FocusNode();

  final List<String> _tutorCountryFilters = [
    "Gia sư Nước Ngoài",
    "Gia sư Việt Nam",
    "Gia sư Tiếng Anh bản ngữ"
  ];
  late List<String> _selectedTutorCountryFilters;

  @override
  void initState() {
    super.initState();
    _tutorDataProvider = Provider.of<TutorDataProvider>(context, listen: false);
    _displayedTutors = _tutorDataProvider.tutors;
    _selectedTutorCountryFilters = [];
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _displayedTutors = getFilteredTutors());
      }
    });
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
                              _selectedTutorCountryFilters = values
                                  .map((e) => _tutorCountryFilters[e])
                                  .toList();
                              _displayedTutors = getFilteredTutors();
                            });
                          },
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
                        width: 170,
                        height: 40,
                        child: TextField(
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
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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

  List<Tutor> getFilteredTutors() {
    List<Tutor> filteredTutors = _tutorDataProvider.tutors
        .where((tutor) => tutor.name
            .toLowerCase()
            .contains(_tutorNameController.text.toLowerCase()))
        .toList();
    if (_selectedTutorCountryFilters.length == 2) {
      // VN && bản ngữ
      if (_selectedTutorCountryFilters.contains("Gia sư Việt Nam") &&
          _selectedTutorCountryFilters.contains("Gia sư Tiếng Anh bản ngữ")) {
        filteredTutors = filteredTutors
            .where(
                (tutor) => !tutor.isForeigner || tutor.isNativeEnglishSpeaker)
            .toList();
      } else // Nước ngoài && bản ngữ
      if (_selectedTutorCountryFilters.contains("Gia sư Nước Ngoài") &&
          _selectedTutorCountryFilters.contains("Gia sư Tiếng Anh bản ngữ")) {
        filteredTutors = filteredTutors
            .where((tutor) => tutor.isForeigner == false)
            .toList();
      }
    }

    if (_selectedTutorCountryFilters.length == 1) {
      // VN
      if (_selectedTutorCountryFilters.contains("Gia sư Việt Nam")) {
        filteredTutors = filteredTutors
            .where((tutor) => tutor.isForeigner == false)
            .toList();
      } else // Nước ngoài
      if (_selectedTutorCountryFilters.contains("Gia sư Nước Ngoài")) {
        filteredTutors =
            filteredTutors.where((tutor) => tutor.isForeigner).toList();
      } else // bản ngữ
      if (_selectedTutorCountryFilters.contains("Gia sư Tiếng Anh bản ngữ")) {
        filteredTutors = filteredTutors
            .where((tutor) => tutor.isNativeEnglishSpeaker)
            .toList();
      }
    }

    return filteredTutors;
  }

  @override
  void dispose() {
    _tutorNameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
