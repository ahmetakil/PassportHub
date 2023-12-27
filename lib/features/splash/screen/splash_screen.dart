import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/models/visa_matrix.dart';
import 'package:passport_hub/common/ui/widgets/hub_loading.dart';
import 'package:passport_hub/features/home/bloc/country_search_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
                    allCountryList: visaMatrix.countryList,
                  ),
                );
            context.goNamed(AppRouter.home);
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
