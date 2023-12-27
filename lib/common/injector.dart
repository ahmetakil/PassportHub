import 'package:get_it/get_it.dart';
import 'package:passport_hub/common/api/country_list_api.dart';
import 'package:passport_hub/common/api/github_country_list_api.dart';
import 'package:passport_hub/common/api/github_visa_api.dart';
import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/repository/country_list_repository.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

Future<void> injectorSetup(GetIt getIt) async {
  getIt.registerLazySingleton<VisaApi>(
    () => GithubVisaApi(),
  );

  getIt.registerLazySingleton<CountryListApi>(
    () => GithubCountryListApi(),
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

  getIt.registerLazySingleton<VisaBloc>(
    () => VisaBloc(
      getIt<VisaRepository>(),
      getIt<CountryListRepository>(),
    ),
  );

  getIt.registerLazySingleton<CountrySearchBloc>(
    () => CountrySearchBloc(),
  );

  await getIt.allReady();
}
