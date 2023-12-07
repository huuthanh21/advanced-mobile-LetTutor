import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/country_mapper.dart';
import '../../../common/widgets/rating_bar.dart';
import '../../../models/tutor.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({
    super.key,
    required this.tutor,
  });

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      height: 400,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(tutor.profilePictureUrl),
                      ),
                    ),
                    const Gap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => context.push(
                            context.namedLocation("tutor",
                                pathParameters: {"tid": tutor.id}),
                          ),
                          child: Text(tutor.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 22)),
                        ),
                        Row(children: [
                          CountryFlag.fromCountryCode(tutor.countryCode,
                              width: 20, height: 20),
                          const Gap(5),
                          Text(
                            CountryMapper.countryCodeToName(tutor.countryCode),
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ]),
                        if (tutor.reviews.isEmpty)
                          Text(
                            "Không có đánh giá",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic),
                          )
                        else
                          RatingBar(rating: tutor.rating),
                      ],
                    )
                  ],
                ), // Header left
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_outlined))
              ],
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (String specialization in tutor.specializations)
                  TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(specialization,
                        style: TextStyle(color: Colors.grey.shade800)),
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Text(
              tutor.description,
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: const Text("Đặt lịch")),
            ),
          ),
        ],
      ),
    );
  }
}
