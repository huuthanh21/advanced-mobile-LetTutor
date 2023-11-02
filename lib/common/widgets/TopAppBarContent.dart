import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopAppBarContent extends StatelessWidget {
  const TopAppBarContent({super.key});

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
            SvgPicture.asset(
              logo,
              height: 40,
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
