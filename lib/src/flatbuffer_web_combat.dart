export 'package:flat_buffers/flat_buffers.dart' hide Int64Reader;

import 'package:flat_buffers/flat_buffers.dart';
import 'dart:typed_data';

const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

class Int64Reader extends Reader<int> {
  const Int64Reader();

  @override
  int read(BufferContext bc, int offset) {
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
