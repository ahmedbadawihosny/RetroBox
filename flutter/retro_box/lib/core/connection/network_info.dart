import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInnfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInnfoImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
