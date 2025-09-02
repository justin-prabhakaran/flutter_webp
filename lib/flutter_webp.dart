import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webp/webp_encode.dart';
import 'package:image/image.dart' as img;

typedef _WebPGetInfoC = Int32 Function(
    Pointer<Uint8>, IntPtr size, Pointer<Int32>, Pointer<Int32>);
typedef _WebPGetInfoDart = int Function(
    Pointer<Uint8>, int, Pointer<Int32>, Pointer<Int32>);

typedef _WebFreeC = Void Function(Pointer<Uint8>);
typedef _WebFreeDart = void Function(Pointer<Uint8>);

class FlutterWebp {
  late final DynamicLibrary _lib;
  late final _WebPGetInfoDart _getInfo;
  // static late final _WebFreeDart _webFree;

  final _encode = WebpEncode();

  FlutterWebp() {
    _lib = DynamicLibrary.open("../linux/libs/libwebp.so");
    _getInfo =
        _lib.lookupFunction<_WebPGetInfoC, _WebPGetInfoDart>("WebPGetInfo");

    // _webFree = _lib.lookupFunction<_WebFreeC, _WebFreeDart>("WebPFree");
  }

  //todo: free used memory - add try catch
  WebPInfo getInfo(Uint8List data) {
    final size = data.length;
    final dataPrt = malloc<Uint8>(size);
    final bytes = dataPrt.asTypedList(size);
    bytes.setAll(0, data);
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

  void encodeImage(Uint8List bytes) async {
    print("req: ${bytes.lengthInBytes}");
    final data = await compute(_encodeImage, bytes);
    print("res: ${data.lengthInBytes}");
  }
}

Uint8List _encodeImage(Uint8List bytes) {
  final encode = WebpEncode();

  final data = img.decodeImage(bytes);
  if (data != null) {
    final bytes = data.getBytes(order: img.ChannelOrder.rgba);
    final output =
        encode.encodeRGBA(bytes, data.width, data.height, data.rowStride, 70);
    return output;
  }

  return Uint8List.fromList([]);
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
