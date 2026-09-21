import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';

import 'base_cubit.dart';
import 'base_state.dart';

abstract class BaseDialog<C extends BaseCubit<S>, S extends BaseState>
    extends StatefulWidget {
  const BaseDialog({super.key});

  Widget builder(BuildContext context, C cubit, S state);

  @override
  State<BaseDialog<C, S>> createState() => _BaseDialogState<C, S>();
}

class _BaseDialogState<C extends BaseCubit<S>, S extends BaseState>
    extends State<BaseDialog<C, S>> {
  @override
  Widget build(BuildContext context) {
    final cubit = getIt<C>();
    return BlocProvider(
      create: (context) => cubit,
      child: Builder(
        builder: (context) {
          return widget.builder(context, cubit, cubit.state);
        },
      ),
    );
  }
}
