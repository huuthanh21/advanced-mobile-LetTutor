import 'package:flutter/material.dart';
import 'package:lettutor/common/widgets/top_app_bar_content.dart';

class TopAppBar extends PreferredSize {
  TopAppBar({super.key, bool isLoggedIn = false})
      : super(
          preferredSize: const Size.fromHeight(80),
          child: TopAppBarContent(isLoggedIn: isLoggedIn),
        );
}
