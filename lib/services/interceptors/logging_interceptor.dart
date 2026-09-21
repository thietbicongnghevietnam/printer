import 'package:dio/dio.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    loggerNoStack.i(
      'Request\nPath: ${options.uri}\nMethod: ${options.method}\nHeader: ${options.headers}\nData: ',
    );
    loggerNoStack.i(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(response, handler) {
    // loggerNoStack.i(
    //   'Response\nPath: ${response.realUri}\nHeader: ${response.headers}\nData: ',
    // );
    loggerNoStack.i(response.data.toString());
    handler.next(response);
  }
}
