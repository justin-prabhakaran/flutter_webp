import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_webp_method_channel.dart';

abstract class FlutterWebpPlatform extends PlatformInterface {
  /// Constructs a FlutterWebpPlatform.
  FlutterWebpPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWebpPlatform _instance = MethodChannelFlutterWebp();

  /// The default instance of [FlutterWebpPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWebp].
  static FlutterWebpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWebpPlatform] when
  /// they register themselves.
  static set instance(FlutterWebpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
