import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/bloc/visa_bloc/visa_bloc.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_error_screen.dart';
import 'package:passport_hub/features/country_details/country_details_screen.dart';
import 'package:passport_hub/features/home/home_screen.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/compare_tab.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/screens/compare_search_screen.dart';
import 'package:passport_hub/features/home/tabs/home_tab/explore_tab.dart';
import 'package:passport_hub/features/home/tabs/travel_tab/travel_tab.dart';
import 'package:passport_hub/features/news/screen/news_details_screen.dart';
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
  static const compareSearch = "compareSearch";
  static const newsDetails = "newsDetails";

  static GoRouter generateGoRouter() {
    return GoRouter(
      observers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      debugLogDiagnostics: true,
      initialLocation: "/",
      redirect: (context, state) {
        final bool hasVisaMatrix = context.read<VisaBloc>().state.hasData;

        if (!hasVisaMatrix &&
            state.fullPath != "/" &&
            state.fullPath != "/splash") {
          return state.namedLocation(
            AppRouter.splash,
            queryParameters: {'from': state.fullPath ?? "/travel"},
          );
        }

        return null;
      },
      routes: [
        GoRoute(
          path: "/",
          redirect: (_, __) => "/splash",
        ),
        GoRoute(
          name: AppRouter.splash,
          path: "/$splash",
          builder: (BuildContext context, GoRouterState state) {
            return SplashScreen(
              deeplinkPath: state.uri.queryParameters['from'],
            );
          },
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
              navigatorKey: travelNavigatorKey,
              initialLocation: "/$travel",
              routes: [
                GoRoute(
                  path: "/$travel",
                  name: AppRouter.travel,
                  builder: (BuildContext context, GoRouterState state) {
                    final String? countryIso = state.uri.queryParameters["iso"];

                    if (countryIso != null) {
                      final Country? country = context
                          .read<VisaBloc>()
                          .state
                          .visaMatrix
                          ?.getCountryByIso(countryIso);

                      if (country != null) {
                        context.read<CountrySearchBloc>().add(
                              SelectCountryEvent(
                                country: country,
                                isUnselectable: true,
                              ),
                            );
                      }
                    }
                    return const TravelTab();
                  },
                ),
              ],
            ),
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
              navigatorKey: compareNavigatorKey,
              initialLocation: "/$compare",
              routes: [
                GoRoute(
                  path: "/$compare",
                  name: AppRouter.compare,
                  builder: (BuildContext context, GoRouterState state) =>
                      const CompareTab(),
                  routes: [
                    GoRoute(
                      path: compareSearch,
                      name: AppRouter.compareSearch,
                      builder: (BuildContext context, GoRouterState state) =>
                          const CompareSearchScreen(),
                    ),
                  ],
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
        GoRoute(
          name: AppRouter.newsDetails,
          path: "/$newsDetails",
          builder: (BuildContext context, GoRouterState state) {
            final String? url = state.extra as String?;

            if (url == null) {
              return const HubErrorScreen(
                errorMessage: "Could not find a valid news url!",
              );
            }

            return NewsDetailsScreen(
              newsUrl: url,
            );
          },
        ),
      ],
    );
  }
}
