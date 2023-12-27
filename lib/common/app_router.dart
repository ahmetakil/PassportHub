import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/features/country_details/country_details_screen.dart';
import 'package:passport_hub/features/home/home_screen.dart';
import 'package:passport_hub/features/search/search_screen.dart';
import 'package:passport_hub/features/splash/screen/splash_screen.dart';

class AppRouter {
  static const splash = "splash";
  static const home = "home";
  static const countryDetails = "countryDetails";
  static const search = "search";

  static GoRouter generateGoRouter() {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          redirect: (_, __) => "/splash",
        ),
        GoRoute(
          name: AppRouter.splash,
          path: "/$splash",
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        ),
        GoRoute(
          name: AppRouter.home,
          path: "/$home",
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        GoRoute(
          name: countryDetails,
          path: "/$countryDetails/:iso",
          builder: (BuildContext context, GoRouterState state) {
            final String? iso = state.pathParameters["iso"];

            if (iso == null) {
              return const HubErrorScreen(
                errorMessage: "Could not find an iso value for CountryDetails!",
              );
            }

            return CountryDetails(
              isoCode: iso,
            );
          },
        ),
        GoRoute(
          name: AppRouter.search,
          path: "/$search",
          builder: (BuildContext context, GoRouterState state) =>
              const SearchScreen(),
        ),
      ],
    );
  }
}
