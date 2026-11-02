import 'package:flutter/services.dart';

class JsonFileExporter {
  const JsonFileExporter._();

  static const _channel = MethodChannel('personal_spending/file');

  static Future<String> saveToDownloads({
    required String fileName,
    required String content,
  }) async {
    final uri = await _channel.invokeMethod<String>('saveJsonToDownloads', {
      'fileName': fileName,
      'content': content,
    });
    if (uri == null) {
      throw PlatformException(
        code: 'export_failed',
        message: 'Download file could not be created.',
      );
    }
    return uri;
  }
}
