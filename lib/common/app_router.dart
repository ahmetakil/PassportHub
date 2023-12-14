import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/features/home/home_screen.dart';
import 'package:passport_hub/features/splash/screen/splash_screen.dart';

class AppRouter {
  static const splash = "splash";
  static const home = "home";

  static GoRouter generateGoRouter() {
    return GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          redirect: (_, __) => splash,
        ),
        GoRoute(
          name: AppRouter.splash,
          path: "/splash",
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        ),
        GoRoute(
          name: AppRouter.home,
          path: "/home",
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
      ],
    );
  }
}
