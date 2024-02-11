import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/widgets/hub_loading.dart';

class SplashScreen extends StatefulWidget {
  final String? deeplinkPath;

  const SplashScreen({
    Key? key,
    this.deeplinkPath,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VisaBloc, VisaState>(
        listener: (context, state) {
          final VisaMatrix? visaMatrix = state.visaMatrix;

          if (visaMatrix != null) {
            HubLogger.log("Forwarding to home page");

            context.read<CountrySearchBloc>().add(
                  SetCountryList(
                    matrix: visaMatrix,
                  ),
                );
            if (widget.deeplinkPath != null) {
              context.go(widget.deeplinkPath!);
            } else {
              context.goNamed(AppRouter.travel);
            }
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: HubLoading(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<VisaBloc>().add(const FetchMatrixEvent());
  }
}
