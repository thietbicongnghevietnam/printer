import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/keyboard.dart';

import 'base_cubit.dart';
import 'base_state.dart';

abstract class BasePage<C extends BaseCubit<S>, S extends BaseState>
    extends StatefulWidget implements AutoRouteWrapper {
  const BasePage({super.key});

  Widget builder(BuildContext context, C cubit, S state) {
    return const SizedBox();
  }

  void onInitState(BuildContext context) {}

  void onDispose(BuildContext context) {}

  C buildCubit(BuildContext context) {
    return getIt<C>();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<C>(
      create: (_) => buildCubit(context),
      child: this,
    );
  }

  void handleError(
      BuildContext context,
      Object? error, [
        StackTrace? stackTrace,
      ]) {
    if (error is ValidationError && !error.type.needConfirm) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          duration: 3.seconds,
          content: Text(error.message),
        ),
      );
    } else {
      final message = error?.as<ErrorEntity>()?.message ??
          LocaleKeys.error_something_error.tr();
      getIt<AppAlertDialog>()
          .show(context, type: AppAlertType.error, message: message);
    }
  }


  @override
  State<BasePage> createState() => BasePageState<C, S>();
}

class BasePageState<C extends BaseCubit<S>, S extends BaseState>
    extends State<BasePage> {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.onInitState(context);
      context.read<C>().initData();
    });
  }

  void onViewLoaded(BuildContext context, C cubit, S state) {}

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    widget.onDispose(context);
  }

  void handleError(
    BuildContext context,
    Object? error, [
    StackTrace? stackTrace,
  ]) {
    widget.handleError(context, error, stackTrace);
  }

  Widget builder(BuildContext context, C cubit, S state) {
    return widget.builder(context, cubit, state);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<C, S>(
            listenWhen: (preState, state) {
              return preState.pageStatus == PageStatus.loading &&
                  state.pageStatus == PageStatus.loaded;
            },
            listener: (context, state) {
              onViewLoaded(context, context.read<C>(), context.read<C>().state);
            },
          ),
          BlocListener<C, S>(
            listenWhen: (preState, state) {
              return preState.processing != state.processing;
            },
            listener: (context, state) {
              if (state.processing) {
                getIt<AppAlertDialog>()
                    .show(context, type: AppAlertType.loading);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<C, S>(
            listenWhen: (preState, state) {
              return preState.errorEntity != state.errorEntity &&
                  state.pageStatus == PageStatus.loaded;
            },
            listener: (context, state) {
              if (state.errorEntity != null) {
                handleError(context, state.errorEntity);
              }
            },
          ),
        ],
        child: BlocSelector<C, S, PageStatus>(
          selector: (state) => state.pageStatus,
          builder: (context, pageStatus) {
            return switch (pageStatus) {
              PageStatus.initial => const _InitialPage(),
              PageStatus.loading => const _LoadingPage(),
              PageStatus.loaded => builder(
                  context,
                  context.read<C>(),
                  context.read<C>().state,
                ),
              PageStatus.error => BlocSelector<C, S, ErrorEntity?>(
                  selector: (state) => state.errorEntity,
                  builder: (context, errorEntity) {
                    return _ErrorPage(
                      message: errorEntity?.message ?? '',
                      retry: () {
                        context.read<C>().retry();
                      },
                    );
                  },
                ),
              PageStatus.loadMore => Stack(
                  children: [
                    builder(
                      context,
                      context.read<C>(),
                      context.read<C>().state,
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: _LoadMorePage(),
                    ),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}

class _InitialPage extends StatelessWidget {
  const _InitialPage();

  @override
  Widget build(_) => const Scaffold();
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _LoadMorePage extends StatelessWidget {
  const _LoadMorePage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        height: 40,
        width: double.infinity,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorPage extends StatelessWidget {
  const _ErrorPage({required this.message, required this.retry});

  final String message;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: retry,
              child: const Text(LocaleKeys.common_retry).tr(),
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
