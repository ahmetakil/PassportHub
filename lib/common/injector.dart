import 'package:get_it/get_it.dart';
import 'package:passport_hub/common/api/country_list_api.dart';
import 'package:passport_hub/common/api/github_country_list_api.dart';
import 'package:passport_hub/common/api/github_visa_api.dart';
import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/repository/country_list_repository.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';
import 'package:passport_hub/features/news/api/google_news_api.dart';
import 'package:passport_hub/features/news/api/news_api.dart';
import 'package:passport_hub/features/news/bloc/news_bloc.dart';
import 'package:passport_hub/features/news/repository/news_repository.dart';

Future<void> injectorSetup(GetIt getIt) async {
  getIt.registerLazySingleton<VisaApi>(
    () => GithubVisaApi(),
  );

  getIt.registerLazySingleton<CountryListApi>(
    () => GithubCountryListApi(),
  );

  getIt.registerLazySingleton<NewsApi>(
    () => GoogleNewsApi(),
  );

  getIt.registerLazySingleton<VisaRepository>(
    () => VisaRepository(
      getIt<VisaApi>(),
    ),
  );

  getIt.registerLazySingleton<CountryListRepository>(
    () => CountryListRepository(
      getIt<CountryListApi>(),
    ),
  );

  getIt.registerLazySingleton<NewsRepository>(
    () => NewsRepository(
      getIt<NewsApi>(),
    ),
  );

  getIt.registerLazySingleton<VisaBloc>(
    () => VisaBloc(
      getIt<VisaRepository>(),
      getIt<CountryListRepository>(),
    ),
  );

  getIt.registerLazySingleton<CountrySearchBloc>(
    () => CountrySearchBloc(),
  );

  getIt.registerLazySingleton<CompareBloc>(
    () => CompareBloc(),
  );

  getIt.registerLazySingleton<NewsBloc>(
    () => NewsBloc(
      getIt<NewsRepository>(),
    )..add(
        FetchNewsEvent(),
      ),
  );

  await getIt.allReady();
}
