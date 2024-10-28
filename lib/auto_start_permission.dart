import 'package:auto_start_permission/auto_start_permission_platform_interface.dart';
import 'package:flutter/foundation.dart';

@immutable
class AutoStartPermission {
  const AutoStartPermission._();

  static const AutoStartPermission _instance = AutoStartPermission._();

  static AutoStartPermission get instance => _instance;

  static AutoStartPermissionPlatform get _platform => AutoStartPermissionPlatform.instance;

  /// Check if this is a MIUI device or not
  Future<bool> isOnMiui() async {
    final res = await _platform.isOnMiui();
    return res ?? false;
  }

  /// Checking if this type of resolution is available for this type of device
  /// Recommended usage with Utils. isOnMiui() Returns whether the Autostart is enabled or not;
  Future<bool> isAutoStartPermissionAvailable() async {
    final res = await _platform.isAutoStartPermissionAvailable();
    return res ?? false;
  }

  /// Autostart permission request
  /// It will attempt to open the specific manufacturer settings screen with the autostart permission
  /// If open is changed to false it will just check the screen existence
  /// Params:
  /// [open] - if true it will attempt to open the activity, otherwise it will just check its existence
  /// [newTask] - if true when the activity is attempted to be opened it will add FLAG_ACTIVITY_NEW_TASK to the intent
  /// Returns:
  /// true if the activity was opened or is confirmed that it exists (depending on open]), false otherwise
  Future<void> requestAutoStartPermission({
    bool open = true,
    bool newTask = true,
  }) =>
      _platform.requestAutoStartPermission(open: open, newTask: newTask);

  /// Checking the status of the permit
  Future<AutoStartPermissionState> checkAutoStartState() async {
    final state = await _platform.checkAutoStartState();
    return AutoStartPermissionState.byName(state);
  }
}

/// Raw State for the autostart ENABLED and DISABLED are the expected results for a MIUI device
enum AutoStartPermissionState {
  enabled,
  disabled,
  noInfo,
  unexpectedResult;

  static AutoStartPermissionState byName(String? name) {
    return switch (name) {
      'ENABLED' => enabled,
      'DISABLED' => disabled,
      'UNEXPECTED_RESULT' => disabled,
      _ => noInfo,
    };
  }
}
