import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/repositories/app_repository.dart';
import 'package:smart_warehouse/services/models/response/api_response_model.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';

class ResponseParserInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['No-Authentication'] == null) {
      final accessToken =
          getIt<StorageManager>().get<String>(StorageKeys.accessToken);
      final finalToken = 'Bearer $accessToken';
      options.headers.remove('No-Authentication');
      options.headers.addAll({'Authorization': finalToken});
    }
    final version = await getIt<AppRepository>().getVersion();
    options.headers.addAll( {'version': version });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(response, handler) {
    final map = response.data is String ? jsonDecode(response.data as String) : response.data;
    if (map['status'] == 200) {
      final data = map['data'];
      response.data = data;
      handler.next(response);
    } else {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
        ),
      );
    }
  }
}
