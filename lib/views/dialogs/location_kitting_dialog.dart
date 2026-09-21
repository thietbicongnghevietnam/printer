import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';

Future<void> locationKittingDialog(
  BuildContext context, {
  required List<String> locations,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => LocationKittingDialog(locations: locations),
  );
}

class LocationKittingDialog extends StatefulWidget {
  const LocationKittingDialog({super.key, required this.locations});

  final List<String> locations;

  @override
  State<LocationKittingDialog> createState() => _LocationKittingDialogState();
}

class _LocationKittingDialogState extends State<LocationKittingDialog> {
  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: const Text('Location'),
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      content: SizedBox(
        height: 150,
        width: double.infinity,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(
                  widget.locations[index],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: widget.locations.length,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Xác Nhận'),
        ).paddingSymmetric(horizontal: 8),
      ],
    );
  }
}
