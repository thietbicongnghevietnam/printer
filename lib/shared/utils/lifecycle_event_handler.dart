import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {

  LifecycleEventHandler({
    this.resumeCallBack,
    this.pauseCallBack,
    this.suspendingCallBack,
  });
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? pauseCallBack;
  final AsyncCallback? suspendingCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack?.call();
        }
      case AppLifecycleState.paused:
        if (pauseCallBack != null) {
          await pauseCallBack?.call();
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        if (suspendingCallBack != null) {
          await suspendingCallBack?.call();
        }
    }
  }
}
