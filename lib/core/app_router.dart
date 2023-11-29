import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/providers/data_provider.dart';
import '../presentation/course_detail/course_detail_page.dart';
import '../presentation/courses/courses_page.dart';
import '../presentation/history/history_page.dart';
import '../presentation/login/login_page.dart';
import '../presentation/login/register_page.dart';
import '../presentation/schedule/schedule_page.dart';
import '../presentation/tutor_detail/tutor_detail_page.dart';
import '../presentation/tutor_list/tutor_list_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        // REDIRECT TO BE IMPLEMENTED
        path: '/',
        name: "login",
        builder: (context, state) => const LoginPage()),
    GoRoute(
        path: '/register',
        name: "register",
        builder: (context, state) => const RegisterPage()),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) => Provider(
        create: (context) => TutorDataProvider(),
        child: const TutorListPage(),
      ),
      routes: [
        GoRoute(
          path: 'tutor',
          name: "tutor",
          builder: (context, state) => const TutorDetailPage(),
        ),
      ],
    ),
    GoRoute(
        path: '/schedule',
        name: "schedule",
        builder: (context, state) => const SchedulePage()),
    GoRoute(
        path: '/history',
        name: "history",
        builder: (context, state) => const HistoryPage()),
    GoRoute(
      path: '/courses',
      name: "courses",
      builder: (context, state) => const CoursesPage(),
      routes: [
        GoRoute(
            path: 'course',
            name: "course",
            builder: (context, state) => const CourseDetailPage()),
      ],
    ),
  ],
);
