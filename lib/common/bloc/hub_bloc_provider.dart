import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';

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
      ],
      child: child,
    );
  }
}
