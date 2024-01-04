import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lettutor/common/providers/data_provider.dart';
import 'package:lettutor/models/course.dart';
import 'package:lettutor/models/ebook.dart';
import 'package:lettutor/presentation/courses/widgets/course_card.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/footer.dart';
import '../../common/widgets/top_app_bar_content.dart';
import 'widgets/ebook_card.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> with SingleTickerProviderStateMixin {
  late List<Course> _displayedCourses;
  late List<Ebook> _displayedEbooks;

  static const List<Tab> tabs = [
    Tab(text: 'Khoá học'),
    Tab(text: 'Ebook'),
    Tab(text: 'Interactive E-book'),
  ];

  late TabController _tabController;

  final _courseNameController = TextEditingController();

  late List<int> _selectedLevelFilters;
  late List<int> _selectedTypeFilters;
  final List<String> difficultyOrders = [
    'Không',
    'Độ khó giảm dần',
    'Độ khó tăng dần',
  ];
  String? _selectedDifficultyOrder;

  @override
  void initState() {
    super.initState();

    _displayedCourses = context.read<CourseDataProvider>().courses;
    _displayedEbooks = context.read<CourseDataProvider>().ebooks;

    _selectedLevelFilters = [];
    _selectedTypeFilters = [];

    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _getTabAtIndex(int index) {
    switch (index) {
      case 0:
        return Consumer<CourseDataProvider>(
          builder: (context, courseDataProvider, child) {
            _displayedCourses = getFilteredCourses();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                courseTypes.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (getCoursesByType(index).isNotEmpty) ...[
                      const Gap(20),
                      Text(
                        courseTypes[index],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(20),
                      Wrap(
                        spacing: 20,
                        runSpacing: 30,
                        children: List.generate(
                          getCoursesByType(index).length,
                          (i) => CourseCard(course: getCoursesByType(index)[i]),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          },
        );
      case 1:
        return Consumer<CourseDataProvider>(
          builder: (context, courseDataProvider, child) {
            _displayedEbooks = getFilteredEbooks();
            return Column(
              children: [
                const Gap(20),
                Wrap(
                  spacing: 20,
                  runSpacing: 30,
                  children: List.generate(
                    _displayedEbooks.length,
                    (i) => EbookCard(ebook: _displayedEbooks[i]),
                  ),
                ),
              ],
            );
          },
        );
      case 2:
        return const Text('Interactive E-book');
      default:
        return const Text(''); // should never happen
    }
  }

  void updateDisplayedItems() {
    setState(() {
      if (_tabController.index == 0) {
        _displayedCourses = getFilteredCourses();
      } else if (_tabController.index == 1) {
        _displayedEbooks = getFilteredEbooks();
      }
    });
  }

  List<Course> getFilteredCourses() {
    List<Course> filteredCourses = context.read<CourseDataProvider>().courses;

    if (_courseNameController.text.isNotEmpty) {
      filteredCourses = filteredCourses
          .where((course) =>
              course.title.toLowerCase().contains(_courseNameController.text.toLowerCase()))
          .toList();
    }

    if (_selectedTypeFilters.isNotEmpty) {
      filteredCourses = filteredCourses
          .where((course) => _selectedTypeFilters.contains(courseTypes.indexOf(course.type)))
          .toList();
    }

    if (_selectedLevelFilters.isNotEmpty) {
      filteredCourses = filteredCourses
          .where((course) => _selectedLevelFilters.contains(course.level.index))
          .toList();
    }

    if (_selectedDifficultyOrder == 'Độ khó giảm dần') {
      filteredCourses.sort((a, b) => b.level.index.compareTo(a.level.index));
    } else if (_selectedDifficultyOrder == 'Độ khó tăng dần') {
      filteredCourses.sort((a, b) => a.level.index.compareTo(b.level.index));
    } else {
      filteredCourses.shuffle();
    }

    return filteredCourses;
  }

  List<Ebook> getFilteredEbooks() {
    List<Ebook> filteredEbooks = context.read<CourseDataProvider>().ebooks;

    if (_courseNameController.text.isNotEmpty) {
      filteredEbooks = filteredEbooks
          .where((ebook) =>
              ebook.title.toLowerCase().contains(_courseNameController.text.toLowerCase()))
          .toList();
    }

    if (_selectedLevelFilters.isNotEmpty) {
      filteredEbooks = filteredEbooks
          .where((ebook) => _selectedLevelFilters.contains(ebook.level.index))
          .toList();
    }

    if (_selectedDifficultyOrder == 'Độ khó giảm dần') {
      filteredEbooks.sort((a, b) => b.level.index.compareTo(a.level.index));
    } else if (_selectedDifficultyOrder == 'Độ khó tăng dần') {
      filteredEbooks.sort((a, b) => a.level.index.compareTo(b.level.index));
    } else {
      filteredEbooks.shuffle();
    }

    return filteredEbooks;
  }

  List<Course> getCoursesByType(int typeIndex) {
    return _displayedCourses.where((course) => course.type == courseTypes[typeIndex]).toList();
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
                          const Gap(20),
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
                                            color: Theme.of(context).colorScheme.tertiary,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: _courseNameController,
                                        decoration: const InputDecoration(
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
                                      onPressed: updateDisplayedItems,
                                      icon: const Icon(Icons.search),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Gap(10),
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
                            child: MultiSelectDialogField(
                              initialValue: _selectedLevelFilters,
                              title: const Text("Chọn cấp độ"),
                              buttonText: const Text(
                                "Chọn cấp độ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              dialogHeight: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                              ),
                              cancelText: const Text("HỦY"),
                              items: Level.values
                                  .mapIndexed((index, value) => MultiSelectItem(
                                        index,
                                        value.name,
                                      ))
                                  .toList(),
                              onConfirm: (values) {
                                setState(() {
                                  _selectedLevelFilters = values.cast<int>();
                                  updateDisplayedItems();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: MultiSelectDialogField(
                              initialValue: _selectedLevelFilters,
                              title: const Text("Chọn danh mục"),
                              buttonText: const Text(
                                "Chọn danh mục",
                                style: TextStyle(color: Colors.grey),
                              ),
                              dialogHeight: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                              ),
                              cancelText: const Text("HỦY"),
                              items: courseTypes
                                  .mapIndexed((index, value) => MultiSelectItem(
                                        index,
                                        value,
                                      ))
                                  .toList(),
                              onConfirm: (values) {
                                setState(() {
                                  _selectedTypeFilters = values.cast<int>();
                                  if (_tabController.index == 0) {
                                    _displayedCourses = getFilteredCourses();
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedDifficultyOrder,
                              hint: const Text('Sắp xếp theo độ khó'),
                              icon: const Icon(Icons.arrow_downward),
                              items: difficultyOrders.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              padding: const EdgeInsets.only(left: 10),
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedDifficultyOrder = value!;
                                  updateDisplayedItems();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: tabs,
                      ),
                      _getTabAtIndex(_tabController.index),
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
