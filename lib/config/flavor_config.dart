import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:logger/logger.dart';

enum Flavor {
  uat,
  dev,
  prod,
  sit,
}

class FlavorConfig {
  static const envFlavor = String.fromEnvironment("FLAVOR");
  static Logger logger = Logger(
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
      dateTimeFormat: DateTimeFormat
          .dateAndTime, // Should each log print contain a timestamp
    ),
  );

  static Flavor get flavor {
    switch (envFlavor) {
      case "dev":
        return Flavor.dev;
      case "uat":
        return Flavor.uat;
      case "prod":
        return Flavor.prod;
      case "sit":
        return Flavor.sit;
      default:
        return Flavor.dev;
    }
  }

  static String get name {
    switch (envFlavor) {
      case "dev":
        return "[DEV] Kai Chat";
      case "uat":
        return "[UAT] Kai Chat";
      case "prod":
        return "Kai Chat";
      case "sit":
        return "[SIT] Kai Chat";
      default:
        return "[DEV] Kai Chat";
    }
  }

  static String get title => name;

  static bool get isUAT => flavor == Flavor.uat;

  static bool get isDevelopment => flavor == Flavor.dev;

  static bool get isProduction => flavor == Flavor.prod;

  static String get fileName {
    switch (flavor) {
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
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? 'MY_FALLBACK';
}
