import 'dart:async';

import 'package:connectivity/connectivity.dart';

enum ConnectivityStatus {
  WiFi,
  Cellular,
  Offline
}
enum ConnectivityHStatus {offline,online}
class ConnectivityService {
  static ConnectivityHStatus connectivityStatus;
  // Create our public controller
  static StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('hello from connectivity');

      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        connectivityStatus = ConnectivityHStatus.online;
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        connectivityStatus = ConnectivityHStatus.online;
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        connectivityStatus = ConnectivityHStatus.offline;
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}