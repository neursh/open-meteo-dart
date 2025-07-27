import 'dart:typed_data';
import 'package:flat_buffers/flat_buffers.dart' as fb;

const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

class MeteoInt64Reader extends fb.Reader<int> {
  const MeteoInt64Reader();

  @override
  int read(fb.BufferContext bc, int offset) {
    if (kIsWeb) {
      // Read as two 32-bit integers and combine
      final low = bc.buffer.getUint32(offset, Endian.little);
      final high = bc.buffer.getUint32(offset + 4, Endian.little);

      // Combine into JavaScript number (loses precision beyond 53 bits)
      return (high * 0x100000000) + low;
    }

    return bc.buffer.getInt64(offset, Endian.little);
  }

  @override
  int get size => 8;
}
