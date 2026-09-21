import 'package:flutter/material.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          if (title != null) Text(title!),
        ],
      ),
    );
  }
}
