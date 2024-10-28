import 'package:auto_start_permission/auto_start_permission.dart';
import 'package:auto_start_permission/auto_start_permission_method_channel.dart';
import 'package:auto_start_permission/auto_start_permission_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAutoStartPermissionPlatform with MockPlatformInterfaceMixin implements AutoStartPermissionPlatform {
  @override
  Future<bool?> isAutoStartPermissionAvailable() async => true;

  @override
  Future<bool?> isOnMiui() {
    // TODO: implement isOnMiui
    throw UnimplementedError();
  }

  @override
  Future<String?> checkAutoStartState() {
    // TODO: implement checkAutoStartState
    throw UnimplementedError();
  }

  @override
  Future<void> requestAutoStartPermission({bool open = false, bool newTask = false}) {
    // TODO: implement requestAutoStartPermission
    throw UnimplementedError();
  }
}

void main() {
  final AutoStartPermissionPlatform initialPlatform = AutoStartPermissionPlatform.instance;

  test('$MethodChannelAutoStartPermission is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAutoStartPermission>());
  });

  test('getPlatformVersion', () async {
    MockAutoStartPermissionPlatform fakePlatform = MockAutoStartPermissionPlatform();
    AutoStartPermissionPlatform.instance = fakePlatform;

    expect(await AutoStartPermission.instance.isAutoStartPermissionAvailable(), true);
  });
}
