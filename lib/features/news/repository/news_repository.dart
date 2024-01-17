import 'package:dart_rss/domain/rss_feed.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/features/news/api/news_api.dart';
import 'package:passport_hub/features/news/api/news_utils.dart';
import 'package:passport_hub/features/news/models/hub_news.dart';

class NewsRepository {
  final NewsApi newsApi;

  NewsRepository(this.newsApi);

  Stream<List<HubNews>> fetchNews() async* {
    const List<String> keywords = newsKeywords;

    for (final keyword in keywords) {
      final String? responseData = await newsApi.fetchNewsForKeyword(keyword);

      if (responseData == null) {
        HubLogger.log("News response is null for keyword: $keyword");
        continue;
      }

      final RssFeed rssFeed = RssFeed.parse(responseData);

      final List<HubNews> newsList = rssFeed.items
          .take(9)
          .map(
            (RssItem item) {
              final String? title = item.title;
              final String? pubDate = item.pubDate;

              if (title == null || pubDate == null) {
                return null;
              }

              return HubNews(
                title: title,
                publishedAt: newsRssDateFormat.parse(pubDate),
                url: item.source?.url ?? "",
                source: item.source?.value,
              );
            },
          )
          .whereType<HubNews>()
          .toList();

      yield newsList;
    }
  }
}
