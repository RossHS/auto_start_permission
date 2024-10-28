import 'package:auto_start_permission/auto_start_permission_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AutoStartPermissionPlatform extends PlatformInterface {
  /// Constructs a AutoStartPermissionPlatform.
  AutoStartPermissionPlatform() : super(token: _token);

  static final Object _token = Object();

  static AutoStartPermissionPlatform _instance = MethodChannelAutoStartPermission();

  /// The default instance of [AutoStartPermissionPlatform] to use.
  ///
  /// Defaults to [MethodChannelAutoStartPermission].
  static AutoStartPermissionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AutoStartPermissionPlatform] when
  /// they register themselves.
  static set instance(AutoStartPermissionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  //-------------------------Services------------------------------//

  Future<bool?> isOnMiui() {
    throw UnimplementedError('isOnMiui() has not been implemented.');
  }

  Future<bool?> isAutoStartPermissionAvailable() {
    throw UnimplementedError('isAutoStartPermissionAvailable() has not been implemented.');
  }

  Future<void> requestAutoStartPermission({bool open = true, bool newTask = true}) {
    throw UnimplementedError('requestAutoStartPermission() has not been implemented.');
  }

  Future<String?> checkAutoStartState() {
    throw UnimplementedError('checkAutoStartState() has not been implemented.');
  }
}