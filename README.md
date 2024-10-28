Note: This Plugin is not implemented for IOS Devices.

Plugin to request/check autostart permission for Android phones (especially MIUI).
Some phone manufacturers (Xiaomi, Honor, Samsung, Huawei, Oppo etc.) make changes to the operation of pure Android, but this plugin allows you to check the status of this permission and open the native auto-start permission screen. In this way, you can fix the application's operation in background/foreground services

The motivation for creating the plugin was that similar plugins do not work with Gradle 8, and many similar ones have not been updated for a long time.

<p>
<a href="https://pub.dev/packages/auto_start_permission"><img src="https://img.shields.io/pub/v/auto_start_permission.svg" alt="pub"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-orange.svg" alt="MIT license"></a>
</p>

## Features

- Can check is MUIU phone or not
- Request AutoStart permission
- Check the current status of AutoStart permission
- Check is AutoStart permission is available on the phone

## Getting Started

To use this plugin, add `auto_start_permission` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  auto_start_permission: ^1.0.1
```


Checking if this type of permission is available for this type of device
```dart
AutoStartPermission.instance.isAutoStartPermissionAvailable();
```

Request autostart permission
```dart
AutoStartPermission.instance.requestAutoStartPermission();
```

You can check if this is a MIUI device or not
```dart
final isOnMiui = await AutoStartPermission.instance.isOnMiui();
```

Checking the status of the permission
```dart
AutoStartPermission.instance.checkAutoStartState();
```

## Addition Information

```
This plugin provides a layer for calling native Android libraries:
https://github.com/judemanutd/AutoStarter
https://github.com/XomaDev/MIUI-Autostart
```