import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../models/course.dart';
import '../../../models/ebook.dart';

class EbookCard extends StatelessWidget {
  const EbookCard({super.key, required this.ebook});

  final Ebook ebook;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(context.namedLocation('course')),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
              blurRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 286,
            height: 400,
            // border and shadow
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  ebook.coverUri.toString(),
                  width: 286,
                  height: 150,
                  fit: BoxFit.fill,
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ebook.title,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      const Gap(10),
                      Text(
                        ebook.description,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        ebook.level.name,
                        style: const TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
