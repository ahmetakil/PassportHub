import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
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
      child: FlutterWebFrame(
        enabled: kIsWeb,
        maximumSize: Size(600.0, 800.0),
        builder: (context) => HubBlocProvider(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationProvider: _router.routeInformationProvider,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            title: 'PassportHub',
            theme: HubTheme.lightTheme,
          ),
        ),
      ),
    );
  }
}
