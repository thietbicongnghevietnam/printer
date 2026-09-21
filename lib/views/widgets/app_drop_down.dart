import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

typedef DropdownOptionToString<T extends Object> = String Function(T option);

typedef DropdownOptionsBuilder<T extends Object> = FutureOr<Iterable<T>>
    Function(TextEditingValue textEditingValue);

class AppDropdown<T extends Object> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.displayStringForOption,
    required this.options,
    this.hint,
    this.value,
    this.onChange,
  });

  final DropdownOptionToString<T> displayStringForOption;
  final T? value;
  final List<T> options;
  final String? hint;
  final ValueChanged<T?>? onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      hint: Text(hint ?? ''),
      value: value,
      items: options
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(displayStringForOption(e)),
            ),
          )
          .toList(),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      isExpanded: true,
      onChanged: onChange ?? (_) {},
    );
  }
}
