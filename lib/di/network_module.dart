import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/flavor_settings.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/interceptors/logging_interceptor.dart';
import 'package:smart_warehouse/services/interceptors/response_parser_interceptor.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getDio() => Dio()
    ..interceptors.addAll([ResponseParserInterceptor(), LoggingInterceptor(),]);

  @singleton
  ApiService getService(Dio client, FlavorSettings flavorSettings) {
    return ApiService(client, baseUrl: flavorSettings.baseUrl);
  }
}
