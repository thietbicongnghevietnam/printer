import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

enum AppAlertType { success, error, warning, confirm, info, loading }

@singleton
class AppAlertDialog {
  Future<void> show(
    BuildContext context, {
    String message = '',
    AppAlertType type = AppAlertType.info,
    bool barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
  }) {
    if (type == AppAlertType.loading) {
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(
                  LocaleKeys.common_loading.tr(),
                  style: context.theme.textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      );
    }
    final coolAlertType = switch (type) {
      AppAlertType.success => CoolAlertType.success,
      AppAlertType.error => CoolAlertType.error,
      AppAlertType.warning => CoolAlertType.warning,
      AppAlertType.confirm => CoolAlertType.confirm,
      AppAlertType.info => CoolAlertType.info,
      AppAlertType.loading => CoolAlertType.loading,
    };

    return CoolAlert.show(
      context: context,
      type: coolAlertType,
      title: _buildTitle(coolAlertType),
      text: message,
      onConfirmBtnTap: onConfirm,
      onCancelBtnTap: onCancel,
      showCancelBtn: onCancel != null  ,
      confirmBtnText: confirmText ?? LocaleKeys.dialog_ok.tr(),
      cancelBtnText: cancelText ?? LocaleKeys.dialog_cancel.tr(),
      barrierDismissible: barrierDismissible,
      textTextStyle: const TextStyle(fontWeight: FontWeight.normal),
    );
  }

  String? _buildTitle(CoolAlertType type) {
    return switch (type) {
      CoolAlertType.success => LocaleKeys.dialog_success.tr(),
      CoolAlertType.error => LocaleKeys.dialog_error.tr(),
      CoolAlertType.warning => LocaleKeys.dialog_warning.tr(),
      CoolAlertType.confirm => LocaleKeys.dialog_confirm.tr(),
      CoolAlertType.info => LocaleKeys.dialog_info.tr(),
      _ => null,
    };
  }

  void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  bool isShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent ?? false;
  }
}
