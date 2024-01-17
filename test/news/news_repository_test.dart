import 'package:flutter_test/flutter_test.dart';
import 'package:passport_hub/features/news/api/google_news_api.dart';
import 'package:passport_hub/features/news/models/hub_news.dart';
import 'package:passport_hub/features/news/repository/news_repository.dart';

void main() {
  group("News Repository Test", () {
    late NewsRepository newsRepository;

    setUpAll(() {
      newsRepository = NewsRepository(
        GoogleNewsApi(),
      );
    });

    test("Fetch news", () async {
      final Stream<List<HubNews>> news = newsRepository.fetchNews();

      final List<HubNews> hubNews = await news.first;

      expect(hubNews.isNotEmpty, isTrue);
    });
  });
}
