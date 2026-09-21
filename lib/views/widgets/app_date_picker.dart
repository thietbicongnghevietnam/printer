import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onChanged,
    this.controller,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onChanged;
  final TextEditingController? controller;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? _selectedDate;
  late TextEditingController _controller;

  @override
  void initState() {
    _selectedDate = widget.initialDate;
    _controller = widget.controller ??
        TextEditingController(text: _selectedDate?.toText());
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate ?? DateTime.now().subtract(100.days),
      //Tuấn Anh sửa ngày
      lastDate: widget.lastDate ?? DateTime.now().add(60.days),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _selectedDate!.toText();
        widget.onChanged(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      readOnly: true,
      controller: _controller,
      onTap: () => _selectDate(context),
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'dd/MM/yyyy',
        hintStyle: TextStyle(color: Colors.grey)
      ),
    );
  }
}
