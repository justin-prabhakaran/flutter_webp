import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

typedef _EncodeRGBAC = IntPtr Function(
    Pointer<Uint8>, Int32, Int32, Int32, Float, Pointer<Pointer<Uint8>>);
typedef _EncodeRGBADart = int Function(
    Pointer<Uint8>, int, int, int, double, Pointer<Pointer<Uint8>>);

class WebpEncode {
  late final DynamicLibrary _lib;
  late final _EncodeRGBADart _encodeRGBA;
  WebpEncode() {
    _lib = DynamicLibrary.open("../linux/libs/libwebp.so");
    _encodeRGBA =
        _lib.lookupFunction<_EncodeRGBAC, _EncodeRGBADart>("WebPEncodeRGBA");
  }

  Uint8List encodeRGBA(
      Uint8List rgba, int width, int height, int stride, double qualityFactor) {
    final size = rgba.length;
    final rgbaPtr = malloc<Uint8>(size);

    final bytes = rgbaPtr.asTypedList(size);
    bytes.setAll(0, rgba);

    final outputPtrPtr = malloc<Pointer<Uint8>>();
    Pointer<Uint8>? outPtr;
    try {
      final resSize = _encodeRGBA(
          rgbaPtr, width, height, stride, qualityFactor, outputPtrPtr);
      if (resSize != 0) {
        outPtr = outputPtrPtr.value;
        final bytes = outPtr.asTypedList(resSize);
        return bytes;
      }
      throw "Something went wrong while encoding data";
    } catch (e, stack) {
      print(e);
      print(stack);
      rethrow;
    } finally {
      if (outPtr != null) {
        // FlutterWebp.free(outPtr);
      }
      malloc.free(outputPtrPtr);
      malloc.free(rgbaPtr);
    }
  }
}
