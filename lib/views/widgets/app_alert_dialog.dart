import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';

class AppDialog extends AlertDialog {
  AppDialog({
    super.key,
    super.icon,
    super.iconColor,
    super.iconPadding,
    super.title,
    super.titleTextStyle,
    Widget? content,
    super.contentTextStyle,
    super.actions,
    super.actionsPadding,
    super.actionsAlignment,
    super.actionsOverflowAlignment,
    super.actionsOverflowDirection,
    super.actionsOverflowButtonSpacing,
    super.buttonPadding,
    super.backgroundColor,
    super.elevation,
    super.shadowColor,
    super.surfaceTintColor,
    super.semanticLabel,
    super.clipBehavior,
    super.shape,
    super.alignment,
  }) : super(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          content: _Content(child: content),
        );
}

class _Content extends StatelessWidget {
  const _Content({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: context.mediaQuerySize.width - 48, child: child);
  }
}
