import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';

class AppExpandableController extends Cubit<bool> {
  AppExpandableController() : super(false);

  void expand() => emit(true);

  void collapse() => emit(false);
}

class AppExpandable extends StatefulWidget {
  const AppExpandable({
    super.key,
    required this.buildHeader,
    required this.buildContent,
  });

  final Widget Function(AppExpandableController, bool) buildHeader;
  final List<Widget> Function(AppExpandableController, bool) buildContent;

  @override
  State<AppExpandable> createState() => _AppExpandableState();
}

class _AppExpandableState extends State<AppExpandable> {
  late final AppExpandableController _controller;

  @override
  void initState() {
    _controller = AppExpandableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _controller,
      child: BlocBuilder<AppExpandableController, bool>(
        builder: (context, isExpand) {
          return Column(
            children: [
              widget.buildHeader(_controller, isExpand),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SizeTransition(sizeFactor: animation, child: child);
                },
                child: isExpand
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Column(
                          children: widget
                              .buildContent(_controller, isExpand)
                              .map(
                                (e) => Row(
                                  children: [
                                    Container(
                                      width: 1,
                                      height: 68,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                      child: e.paddingSymmetric(vertical: 4),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          );
        },
      ),
    );
  }
}
