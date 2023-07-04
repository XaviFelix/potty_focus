import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDataModel {
  bool _isTimerRunning = false;
  bool _isResetPressed = false;

  bool get isTimerRunning => _isTimerRunning;
  bool get isResetPressed => _isResetPressed;

  void setTimerRunning(bool currentState) => _isTimerRunning = currentState;
  void setResetStatus(bool currentState) => _isResetPressed = currentState;

  List<Application> listOfSystemApps = [];
  Map<String, bool> lockStatusMap = {};

  void setLockStatusCurrentApp(Application currentApp, bool currentStatus) {
    lockStatusMap[currentApp.packageName] = currentStatus;

    print('App: ${currentApp.appName}, Locked: $currentStatus');
  }

  Future<void> loadApps() async {
    List<Application> systemApps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    listOfSystemApps = systemApps;
    lockStatusMap = { for (var app in listOfSystemApps) app.packageName :
    prefs.getBool(app.packageName) ?? false };

  }

  Future<void> lockApp(Application currentApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(currentApp.packageName, true);

    print("This app is currently locked: ${currentApp.appName}");
  }

  void unlockAllApps()
  {
    for(var key in lockStatusMap.keys) {
      lockStatusMap[key] = false;
    }
  }

  void lockAllApps()
  {
    for(var key in lockStatusMap.keys) {
      lockStatusMap[key] = true;
    }
  }

  void printAppLockState(){
    int i = 0;
    for(var key in lockStatusMap.keys) {
      print("${listOfSystemApps[i].appName} : ${lockStatusMap[key]}");
      i++;
    }
  }
}
