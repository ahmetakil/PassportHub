import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/hub_logger.dart';

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
          if (state.visaMatrix != null) {
            HubLogger.log("Forwarding to home page");
            context.goNamed(AppRouter.home);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            child: const Text("A"),
          );
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
