import 'dart:developer' as dev;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class HubLogger {
  static const _instance = HubLogger._();

  const HubLogger._();

  factory HubLogger() => _instance;

  static void log(
    String message, {
    Severity severity = Severity.info,
    Map<String, String>? metadata,
  }) {
    FirebaseCrashlytics.instance.log("Log[$severity] : $message");
    dev.log(
      "${severity.icon} $message",
    );
  }

  static void e(
    String message, {
    Severity severity = Severity.error,
    StackTrace? stackTrace,
    Map<String, String>? metadata,
  }) {
    FirebaseCrashlytics.instance.log("Error[$severity] : $message");
    FirebaseCrashlytics.instance.recordError("Error: $message", stackTrace);
    dev.log(
      "${severity.icon} $message",
      stackTrace: stackTrace,
    );
  }
}

enum Severity {
  debug(icon: '🏗️'),
  info(icon: 'ℹ️'),
  error(icon: '🚨');

  final String icon;

  const Severity({required this.icon});
}
