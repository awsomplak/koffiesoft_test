import 'package:koffiesoft_test/config/contant.dart';
import 'package:logger/logger.dart';

class Log {
  static PrettyPrinter config = PrettyPrinter(colors: true);
  static Logger logger = Logger(printer: config);

  static void d(dynamic message) {
    if (Constant.RELEASE_MODE == 'development') logger.d(message);
  }

  static void e(dynamic message) {
    if (Constant.RELEASE_MODE == 'development') logger.e(message);
  }

  static void i(dynamic message) {
    if (Constant.RELEASE_MODE == 'development') logger.i(message);
  }

  static void w(dynamic message) {
    if (Constant.RELEASE_MODE == 'development') logger.w(message);
  }

  static void v(dynamic message) {
    if (Constant.RELEASE_MODE == 'development') logger.v(message);
  }

  static void log(Level level, dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    if (Constant.RELEASE_MODE == 'development') {
      logger.log(level, message, [error, stackTrace]);
    }
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Constant.RELEASE_MODE == 'development') {
      logger.wtf(message, [error, stackTrace]);
    }
  }
}
