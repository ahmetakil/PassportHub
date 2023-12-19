import 'dart:developer' as dev;

class HubLogger {
  static const _instance = HubLogger._();

  const HubLogger._();

  factory HubLogger() => _instance;

  static void log(
    String message, {
    Severity severity = Severity.info,
    Map<String, String>? metadata,
  }) {
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
