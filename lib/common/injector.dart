import 'package:get_it/get_it.dart';
import 'package:passport_hub/common/api/github_visa_api.dart';
import 'package:passport_hub/common/api/visa_api.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/repository/visa_repository.dart';

Future<void> injectorSetup(GetIt getIt) async {
  getIt.registerLazySingleton<VisaApi>(
    () => GithubVisaApi(),
  );

  getIt.registerLazySingleton<VisaRepository>(
    () => VisaRepository(
      getIt<VisaApi>(),
    ),
  );

  getIt.registerLazySingleton<VisaBloc>(
    () => VisaBloc(
      getIt<VisaRepository>(),
    ),
  );

  await getIt.allReady();
}
