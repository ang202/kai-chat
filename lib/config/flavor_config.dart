import 'package:kai_chat/core/values/app_values.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

enum Flavor {
  uat,
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String? name;
  final Logger logger;
  static late FlavorConfig _instance;

  factory FlavorConfig({required Flavor flavor, required String name, logger}) {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: AppValues.loggerMethodCount,
        // number of method calls to be displayed
        errorMethodCount: AppValues.loggerErrorMethodCount,
        // number of method calls if stacktrace is provided
        lineLength: AppValues.loggerLineLength,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false, // Should each log print contain a timestamp
      ),
    );

    return _instance = FlavorConfig._internal(flavor, name, logger);
  }

  FlavorConfig._internal(this.flavor, this.name, this.logger);

  static FlavorConfig get instance => _instance;

  static String get title => instance.name ?? '';

  static bool get isUAT => _instance.flavor == Flavor.uat;

  static bool get isDevelopment => _instance.flavor == Flavor.dev;

  static bool get isProduction => _instance.flavor == Flavor.prod;

  static String get fileName {
    switch (instance.flavor) {
      case Flavor.dev:
        return '.env.dev';
      case Flavor.prod:
        return '.env.prod';
      case Flavor.uat:
        return '.env.uat';
      default:
        return '';
    }
  }

  static String get openAiKey => dotenv.env['OPENAI_API_KEY'] ?? 'MY_FALLBACK';
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
  static String get sentryDsn => dotenv.env['sentryDsn'] ?? 'MY_FALLBACK';
}
