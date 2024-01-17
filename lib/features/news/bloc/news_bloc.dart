import 'package:bloc/bloc.dart';
import 'package:passport_hub/features/news/models/hub_news.dart';
import 'package:passport_hub/features/news/repository/news_repository.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository)
      : super(
          const NewsState(
            hubNews: [],
          ),
        ) {
    on<FetchNewsEvent>((event, emit) async {
      await emit.forEach(
        repository.fetchNews(),
        onData: (List<HubNews> newsList) {
          final List<HubNews> currentNews = [...state.hubNews];

          currentNews.addAll(newsList);

          currentNews.sort(
            (news1, news2) => news2.publishedAt.compareTo(news1.publishedAt),
          );

          return NewsState(
            hubNews: currentNews,
          );
        },
      );
    });
  }
}
