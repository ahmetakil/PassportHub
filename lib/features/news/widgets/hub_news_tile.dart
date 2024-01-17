import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/features/news/models/hub_news.dart';
import 'package:timeago/timeago.dart' as timeago;

class HubNewsTile extends StatelessWidget {
  final HubNews hubNews;

  const HubNewsTile({
    super.key,
    required this.hubNews,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRouter.newsDetails,
          extra: hubNews.url,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: HubTheme.textFieldBackground.withOpacity(0.5),
          borderRadius: BorderRadius.circular(
            HubTheme.hubBorderRadius,
          ),
        ),
        padding: const EdgeInsets.only(
          left: HubTheme.hubSmallPadding,
          right: HubTheme.hubSmallPadding,
          top: HubTheme.hubMediumPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Text(
                hubNews.title,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: HubTheme.hubTinyPadding,
              ),
              child: Row(
                children: [
                  if (hubNews.source != null)
                    Text(
                      hubNews.source!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  const Spacer(),
                  Text(
                    timeago.format(
                      hubNews.publishedAt,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
