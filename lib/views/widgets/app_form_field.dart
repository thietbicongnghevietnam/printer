import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';

class AppFormField extends StatefulWidget {
  const AppFormField({
    super.key,
    this.focusNode,
    this.decoration,
    this.keyboardType = TextInputType.text,
    this.style,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.showClear = true,
    this.enabled = true,
    this.showCursor,
    this.onChanged,
    this.onClear,
    this.controller,
    this.onTap,
    this.inputFormatters,
    this.initialValue,
    this.onFieldSubmitted,
    this.textAlignVertical,
    this.textAlign = TextAlign.start,
    this.validator,
  });

  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final TextStyle? style;
  final bool obscureText;
  final bool readOnly;
  final bool autoFocus;
  final bool showClear;
  final bool? showCursor;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;


  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool isShowClearButton = false;

  VoidCallback? listener;

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (!mounted) {
        return;
      }
      setState(() {
        isShowClearButton = widget.controller?.text.isNotEmpty ?? false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDecorator = (widget.decoration ?? const InputDecoration())
        .applyDefaults(context.theme.inputDecorationTheme);
    return TextFormField(
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      textAlignVertical: widget.textAlignVertical,
      textAlign: widget.textAlign,
      validator: widget.validator,
onFieldSubmitted: widget.onFieldSubmitted,
      decoration: effectiveDecorator.copyWith(
        suffixIcon: effectiveDecorator.suffixIcon ??
            Visibility(
              visible: widget.showClear && isShowClearButton,
              child: IconButton(
                onPressed: () {
                  widget.controller?.clear();
                  widget.onClear?.call();
                  widget.onChanged?.call(widget.controller?.text ?? '');
                  widget.focusNode?.requestFocus();
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
            ),
      ),
      keyboardType: widget.keyboardType,
      style: widget.style,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      enabled: widget.enabled,
    );
  }
}
