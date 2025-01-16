import 'package:get/get.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/base/model/user.dart';
import 'package:kai_chat/core/repositories/local_repository.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService extends GetxService {
  /// This method reports error to the Sentry Log.
  static Future<void> reportError(
      {required Object error,
      required StackTrace stackTrace,
      required bool shouldReportError}) async {
    final Logger logger = FlavorConfig.instance.logger;

    final LocalRepository localRepository = Get.find();

    /// Pass [shouldReportError] boolean as true if want to report error.
    if (!shouldReportError) {
      return;
    }

    final User? user = await localRepository.getUser();

    /// Report the error to the Sentry.io
    final SentryId sentryId = await Sentry.captureException(error,
        stackTrace: stackTrace, withScope: (scope) {
      scope.setUser(SentryUser(id: user?.id ?? "", username: user?.name ?? ""));
    });

    if (sentryId.toString().isNotEmpty) {
      logger.i('Sentry Report Success! Event ID: $sentryId');
    } else {
      logger.i('Failed to report to Sentry.io');
    }
  }
}
