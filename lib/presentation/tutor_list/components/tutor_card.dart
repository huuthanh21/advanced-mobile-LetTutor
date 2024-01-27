import 'dart:developer';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/presentation/tutor_list/providers/favorite_tutors_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/country_mapper.dart';
import '../../../common/widgets/rating_bar.dart';
import '../../../models/tutor.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({
    super.key,
    required this.tutor,
  });

  final Tutor tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteTutorsProvider>(
      builder:
          (BuildContext context, FavoriteTutorsProvider favoriteTutorsProvider, Widget? child) =>
              Container(
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
                          child: Image.network(widget.tutor.profilePictureUrl),
                        ),
                      ),
                      const Gap(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              log("Go to tutor detail page ${widget.tutor.id}");
                              context.push(
                                context.namedLocation("tutor",
                                    pathParameters: {"tid": widget.tutor.id}),
                              );
                            },
                            child: Text(widget.tutor.name,
                                style:
                                    Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22)),
                          ),
                          Row(children: [
                            CountryFlag.fromCountryCode(widget.tutor.countryCode,
                                width: 20, height: 20),
                            const Gap(5),
                            Text(
                              CountryMapper.countryCodeToName(widget.tutor.countryCode),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ]),
                          if (widget.tutor.calculatedRating == 0)
                            Text(
                              "Không có đánh giá",
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                            )
                          else
                            RatingBar(rating: widget.tutor.calculatedRating.round()),
                        ],
                      )
                    ],
                  ), // Header left
                  if (favoriteTutorsProvider.isFavorite(widget.tutor.id))
                    IconButton(
                        onPressed: () {
                          log("Remove favorite tutor ${widget.tutor.id}");
                          favoriteTutorsProvider.removeFavoriteTutor(widget.tutor.id);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ))
                  else
                    IconButton(
                        onPressed: () {
                          log("Add favorite tutor ${widget.tutor.id}");
                          favoriteTutorsProvider.addFavoriteTutor(widget.tutor.id);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                        ))
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
                  for (String specialization in widget.tutor.specializations)
                    TextButton(
                      onPressed: null,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(specialization, style: TextStyle(color: Colors.grey.shade800)),
                    ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Text(
                widget.tutor.description,
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
                    onPressed: () => context.push(
                        context.namedLocation("tutor", pathParameters: {"tid": widget.tutor.id})),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: const Text("Đặt lịch")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
