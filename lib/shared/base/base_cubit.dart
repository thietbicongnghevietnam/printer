import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';

import 'base_state.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);

  Future<T> launch<T>(
    Future<T> Function() future, {
    bool isShowLoading = true,
    Future<T> Function(Object? error, StackTrace? stackTrace)? onError,
  }) async {
    try {
      if (state.pageStatus != PageStatus.loaded && isShowLoading) {
        emit(state.copyWith(pageStatus: PageStatus.loading) as S);
      } else {
        emit(state.copyWith(processing: true, errorEntity: null) as S);
      }
      return await future().then((value) {
        if (state.pageStatus != PageStatus.loaded) {
          emit(state.copyWith(pageStatus: PageStatus.loaded) as S);
        } else {
          emit(state.copyWith(processing: false) as S);
        }
        return value;
      });
    } catch (error, stackTrace) {
      if (state.pageStatus != PageStatus.loaded) {
        emit(state.copyWith(pageStatus: PageStatus.error) as S);
      } else {
        emit(state.copyWith(processing: false) as S);
      }
      await onError?.call(error, stackTrace) ?? handleError(error, stackTrace);
      return Future.error(error, stackTrace);
    }
  }

  void handleError(Object? error, [StackTrace? stackTrace]) {
    if (state.errorEntity != null) {
      return;
    }
    final errorEntity = error is DioException
        ? ServerError.fromDioException(error)
        : error?.as<ErrorEntity>() ?? UnknownError();
    emit(state.copyWith(errorEntity: errorEntity) as S);
  }

  Future<void> initData() async {}

  Future<void> retry() async {
    await initData();
  }
}
