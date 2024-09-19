import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkChecker {
  final _networkStatusController = StreamController<NetworkStatus>.broadcast();

  NetworkChecker() {
    _monitorNetworkStatus();
  }

  Stream<NetworkStatus> get networkStatusStream => _networkStatusController.stream;

  void _monitorNetworkStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        // No internet connection
        _networkStatusController.add(NetworkStatus.noInternet);
      } else {
        // Check for slow or fast internet
        bool isSlow = await _checkInternetSpeed();
        if (isSlow) {
          _networkStatusController.add(NetworkStatus.slowInternet);
        } else {
          _networkStatusController.add(NetworkStatus.connected);
        }
      }
    });
  }

  Future<bool> _checkInternetSpeed() async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await http.get(Uri.parse('https://www.google.com'));
      stopwatch.stop();

      if (stopwatch.elapsedMilliseconds > 2000 || response.statusCode != 200) {
        return true; // Internet is slow
      }
    } catch (e) {
      return true; // No connection or very slow
    }
    return false; // Internet is fast
  }

  void dispose() {
    _networkStatusController.close();
  }
}

enum NetworkStatus { connected, noInternet, slowInternet }
