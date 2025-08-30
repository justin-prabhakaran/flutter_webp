import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webp/flutter_webp.dart';
import 'package:flutter_webp/flutter_webp_platform_interface.dart';
import 'package:flutter_webp/flutter_webp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterWebpPlatform
    with MockPlatformInterfaceMixin
    implements FlutterWebpPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterWebpPlatform initialPlatform = FlutterWebpPlatform.instance;

  test('$MethodChannelFlutterWebp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterWebp>());
  });

  test('getPlatformVersion', () async {
    FlutterWebp flutterWebpPlugin = FlutterWebp();
    MockFlutterWebpPlatform fakePlatform = MockFlutterWebpPlatform();
    FlutterWebpPlatform.instance = fakePlatform;

    expect(await flutterWebpPlugin.getPlatformVersion(), '42');
  });
}
