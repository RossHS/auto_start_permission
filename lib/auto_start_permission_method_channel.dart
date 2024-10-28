import 'package:auto_start_permission/auto_start_permission_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [AutoStartPermissionPlatform] that uses method channels.
class MethodChannelAutoStartPermission extends AutoStartPermissionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('auto_start_permission_plugin');

  @override
  Future<bool?> isOnMiui() {
    return methodChannel.invokeMethod('isOnMiui');
  }

  @override
  Future<bool?> isAutoStartPermissionAvailable() =>
      methodChannel.invokeMethod('isAutoStartPermissionAvailable');

  @override
  Future<String?> checkAutoStartState() =>
      methodChannel.invokeMethod('checkAutoStartPermissionState');

  @override
  Future<void> requestAutoStartPermission(
      {bool open = false, bool newTask = false}) {
    return methodChannel.invokeMethod(
      'requestAutoStartPermission',
      {
        'open': open,
        'newTask': newTask,
      },
    );
  }
}
