import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

class AppObserver extends BlocObserver {
  @override
  void onCreate(bloc) {
    loggerNoStack.i('Bloc ${bloc.runtimeType} Created');
    super.onCreate(bloc);
  }

  @override
  void onChange(bloc, change) {
    loggerNoStack.i(
      'Bloc ${bloc.runtimeType} State Changed:\nCurrent State: ${change
          .currentState}\nNext State:    ${change.nextState}',
    );

    super.onChange(bloc, change);
  }

  @override
  void onClose(bloc) {
    loggerNoStack.i('Bloc ${bloc.runtimeType} Closed');
    super.onClose(bloc);
  }
}
