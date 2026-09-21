import 'package:flutter/material.dart';

class AppAutoComplete<T extends Object> extends StatelessWidget {
  const AppAutoComplete({
    super.key,
    this.initialValue,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    required this.optionsBuilder,
    this.onSelect,
    this.controller,
    this.decoration,
    this.readOnly = false,
    this.focusNode,
  });

  final T? initialValue;
  final AutocompleteOptionToString<T> displayStringForOption;
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final ValueChanged<T?>? onSelect;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return RawAutocomplete<T>(
          initialValue: initialValue != null
              ? TextEditingValue(
                  text: displayStringForOption(initialValue!),
                )
              : null,
          optionsBuilder: optionsBuilder,
          displayStringForOption: displayStringForOption,
          onSelected: onSelect,
          focusNode: focusNode,
          textEditingController: controller,
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              readOnly: readOnly,
              decoration: decoration ??
                  const InputDecoration(suffixIcon: Icon(Icons.search)),
              focusNode: focusNode,
              onFieldSubmitted: (value) => onFieldSubmitted(),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            if (readOnly) {
              return const SizedBox();
            }
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.white,
                elevation: 10,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        dense: true,
                        title: Text(
                          displayStringForOption(options.elementAt(index)),
                        ),
                        onTap: () => onSelected(options.toList()[index]),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
