import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  const NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> get isConnected async {
    final List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
