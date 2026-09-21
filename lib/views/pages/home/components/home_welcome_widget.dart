import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class HomeWelcomeWidget extends StatelessWidget {
  const HomeWelcomeWidget({
    super.key,
    required this.userId,
    required this.onLogout,
  });

  final String userId;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AppText.title(LocaleKeys.home_hello).tr(args: [userId]),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
}
