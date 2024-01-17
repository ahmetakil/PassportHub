import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/news/bloc/news_bloc.dart';
import 'package:passport_hub/features/news/models/hub_news.dart';
import 'package:passport_hub/features/news/widgets/hub_news_tile.dart';

class HubNewsList extends StatelessWidget {
  const HubNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final List<HubNews> news = state.hubNews;

        if (news.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(
            bottom: HubTheme.hubMediumPadding,
            left: HubTheme.hubMediumPadding,
            right: HubTheme.hubMediumPadding,
          ),
          child: CarouselSlider.builder(
            itemCount: news.length,
            options: CarouselOptions(
              aspectRatio: 4 / 3,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              height: 120,
            ),
            itemBuilder: (context, i, _) => HubNewsTile(
              hubNews: news[i],
            ),
          ),
        );
      },
    );
  }
}
