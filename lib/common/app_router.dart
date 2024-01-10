import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/features/country_details/country_details_screen.dart';
import 'package:passport_hub/features/home/home_screen.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/compare_tab.dart';
import 'package:passport_hub/features/home/tabs/home_tab/explore_tab.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/travel_tab.dart';
import 'package:passport_hub/features/search/search_screen.dart';
import 'package:passport_hub/features/splash/screen/splash_screen.dart';

final GlobalKey<NavigatorState> exploreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "exploreNavigator");
final GlobalKey<NavigatorState> travelNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "travelNavigator");
final GlobalKey<NavigatorState> compareNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "compareNavigator");

class AppRouter {
  static const splash = "splash";
  static const home = "home";
  static const countryDetails = "countryDetails";
  static const search = "search";
  static const explore = "explore";
  static const travel = "travel";
  static const compare = "compare";

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
        StatefulShellRoute(
          builder: (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) {
            return navigationShell;
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: exploreNavigatorKey,
              initialLocation: "/$explore",
              routes: [
                GoRoute(
                  path: "/$explore",
                  name: AppRouter.explore,
                  builder: (BuildContext context, GoRouterState state) =>
                      const ExploreTab(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: travelNavigatorKey,
              initialLocation: "/$travel",
              routes: [
                GoRoute(
                  path: "/$travel",
                  name: AppRouter.travel,
                  builder: (BuildContext context, GoRouterState state) =>
                      const TravelTab(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: compareNavigatorKey,
              initialLocation: "/$compare",
              routes: [
                GoRoute(
                  path: "/$compare",
                  name: AppRouter.compare,
                  builder: (BuildContext context, GoRouterState state) =>
                      const CompareTab(),
                ),
              ],
            ),
          ],
          navigatorContainerBuilder: (
            BuildContext context,
            StatefulNavigationShell navigationShell,
            List<Widget> children,
          ) {
            return HomeScreen(
              navigationShell: navigationShell,
              children: children,
            );
          },
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
