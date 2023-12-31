import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:passport_hub/common/app_router.dart';
import 'package:passport_hub/common/bloc/hub_bloc_provider.dart';
import 'package:passport_hub/common/injector.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await injectorSetup(GetIt.I);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.generateGoRouter();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: HubBlocProvider(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          title: 'PassportHub',
          theme: HubTheme.lightTheme,
        ),
      ),
    );
  }
}

/*
1. Hero animation bug
2. Keyboard popping up when navigated to search
3. Make travel page more understandable
  a. Make title as Travel together
  b. Info button with bottom sheet
4. Update country details with real values
5. Update Travel -> List to match the company details
6. Compare
7. Map colors
8. Firebase and more data
9. Display country name overlay when tapped on the map
10. Add filtering to Travel -> List.
*/
