import 'package:auto_start_permission/auto_start_permission.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isMiui = false;
  bool _isAutoStartPermissionAvailable = false;
  var _autoStartPermissionState = AutoStartPermissionState.noInfo;

  @override
  void initState() {
    super.initState();
    AutoStartPermission.instance.isOnMiui().then((val) {
      setState(() {
        _isMiui = val;
      });
    });
    AutoStartPermission.instance.isAutoStartPermissionAvailable().then((val) {
      setState(() {
        _isAutoStartPermissionAvailable = val;
      });
    });
    _checkPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Auto Start Permission Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Is Miui: $_isMiui'),
              Text('Is AutoStart Permission Available: $_isAutoStartPermissionAvailable'),
              Text('AutoStartPermissionState: ${_autoStartPermissionState.name}'),
              ElevatedButton(
                onPressed: () async {
                  await AutoStartPermission.instance.requestAutoStartPermission();
                  _checkPermissionStatus();
                },
                child: const Text('request AutoStart Permission'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkPermissionStatus() {
    AutoStartPermission.instance.checkAutoStartState().then(
      (value) {
        setState(() {
          _autoStartPermissionState = value;
        });
      },
    );
  }
}
