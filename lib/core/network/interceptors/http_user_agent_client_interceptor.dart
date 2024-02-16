import 'package:dio/dio.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

class HttpUserAgentClientInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add User-Agent Client Hints
    final Map<String, String> userAgentClintHintsData = await userAgentClientHintsHeader();

    options.headers.addAll({
      'User-Agent': await userAgent(),
      'Sec-CH-UA-Mobile': userAgentClintHintsData['Sec-CH-UA-Mobile'],
      'Sec-CH-UA-Arch': userAgentClintHintsData['Sec-CH-UA-Arch'],
      'Sec-CH-UA-Model': userAgentClintHintsData['Sec-CH-UA-Model'],
      'Sec-CH-UA-Platform': userAgentClintHintsData['Sec-CH-UA-Platform'],
      'Sec-CH-UA-Platform-Version': userAgentClintHintsData['Sec-CH-UA-Platform-Version'],
      'Sec-CH-UA': userAgentClintHintsData['Sec-CH-UA'],
      'Sec-CH-UA-Full-Version': userAgentClintHintsData['Sec-CH-UA-Full-Version'],
    });

    return handler.next(options);
  }
}
