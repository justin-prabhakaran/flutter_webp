
import 'flutter_webp_platform_interface.dart';

class FlutterWebp {
  Future<String?> getPlatformVersion() {
    return FlutterWebpPlatform.instance.getPlatformVersion();
  }
}
