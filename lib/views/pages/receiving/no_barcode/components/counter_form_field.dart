import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

class CounterFormField extends AppFormField {
  CounterFormField({
    super.key,
    super.autoFocus,
    super.controller,
    super.enabled,
    super.focusNode,
    super.initialValue,
    super.obscureText,
    super.onChanged,
    super.onClear,
    super.onTap,
    super.readOnly,
    super.showClear,
    super.showCursor,
    super.style,
    super.validator,
    InputDecoration? inputDecoration,
  }) : super(
    textAlign: TextAlign.center,
    keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          decoration: (inputDecoration ?? const InputDecoration()).copyWith(
            prefixIcon: IconButton(
              onPressed: () {
                final number = controller?.text.toInt() ?? 1;
                if (number > 1) {
                  controller?.text = (number - 1).toString();
                  onChanged?.call(controller?.text ?? '');
                } else {
                  onClear?.call();
                }
              },
              icon: const Icon(Icons.remove),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                final number = controller?.text.toInt() ?? 1;
                if (number < 99) {
                  controller?.text = (controller.text.toInt() + 1).toString();
                  onChanged?.call(controller?.text ?? '');
                }
              },
              icon: const Icon(Icons.add),
            ),
          ),
        );
}
