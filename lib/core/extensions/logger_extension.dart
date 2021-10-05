import 'dart:developer' show log;

extension LoggerExtension<T> on T {
  void logger() => log('=> $this', name: 'LOGGER-EXTENSION');
}
