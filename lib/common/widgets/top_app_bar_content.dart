import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TopAppBarContent extends StatelessWidget {
  final bool isLoggedIn;
  const TopAppBarContent({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    const String logo = "images/lettutor_logo.svg";
    const String vietnam = "images/vietnam.svg";
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: InkWell(
                    onTap: () => context.go(context.namedLocation('home')),
                    child: SvgPicture.asset(
                      logo,
                      height: 40,
                    ),
                  ),
                ),
                if (isLoggedIn)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => context.go(context.namedLocation('home')),
                        child: Text(
                          "GIA SƯ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        child: Text(
                          "LỊCH HỌC",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        onTap: () =>
                            context.go(context.namedLocation('schedule')),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        child: Text(
                          "LỊCH SỬ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        onTap: () =>
                            context.go(context.namedLocation('history')),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                          child: Text(
                            "KHÓA HỌC",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          onTap: () =>
                              context.go(context.namedLocation('courses'))),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        child: Text(
                          "KHÓA HỌC CỦA TÔI",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  )
              ],
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      vietnam,
                      height: 20,
                      width: 20,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
