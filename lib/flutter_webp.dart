import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

typedef _WebPGetInfoC = Int32 Function(
    Pointer<Uint8>, IntPtr size, Pointer<Int32>, Pointer<Int32>);
typedef _WebPGetInfoDart = int Function(
    Pointer<Uint8>, int, Pointer<Int32>, Pointer<Int32>);

class FlutterWebp {
  late final DynamicLibrary _lib;
  late final _WebPGetInfoDart _getInfo;

  FlutterWebp() {
    _lib = DynamicLibrary.open("../linux/libs/libwebp.so");
    _getInfo =
        _lib.lookupFunction<_WebPGetInfoC, _WebPGetInfoDart>("WebPGetInfo");
  }

  WebPInfo getInfo(Uint8List data) {
    final size = data.length;
    final dataPrt = malloc<Uint8>(size);

    final widthPtr = malloc<Int32>();
    final heightPtr = malloc<Int32>();

    final res = _getInfo(dataPrt, size, widthPtr, heightPtr);
    print("result : $res");
    print("Width: ${widthPtr.value}  Height: ${heightPtr.value}");

    if (res != 0) {
      return WebPInfo(width: widthPtr.value, height: heightPtr.value, ok: true);
    }

    return WebPInfo(height: -1, ok: false, width: -1);
  }

  void hello() {
    print("hellow wordld");
  }
}

class WebPInfo {
  final int width;
  final int height;
  final bool ok;

  const WebPInfo({
    required this.width,
    required this.height,
    required this.ok,
  });
}
