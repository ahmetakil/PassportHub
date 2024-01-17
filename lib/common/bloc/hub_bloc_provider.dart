import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/features/news/bloc/news_bloc.dart';

class HubBlocProvider extends StatelessWidget {
  final Widget child;

  const HubBlocProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VisaBloc>(
          create: (_) => GetIt.I.get<VisaBloc>(),
        ),
        BlocProvider<CountrySearchBloc>(
          create: (_) => GetIt.I.get<CountrySearchBloc>(),
        ),
        BlocProvider<NewsBloc>(
          create: (_) => GetIt.I.get<NewsBloc>(),
        ),
      ],
      child: child,
    );
  }
}
