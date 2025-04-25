// Stub implementation for dart:io functionality on web platforms
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

// File stub implementation for web
class File {
  final String path;

  File(this.path);

  Future<Uint8List> readAsBytes() async {
    throw UnsupportedError('File I/O is not supported on web platform');
  }

  Future<String> readAsString() async {
    throw UnsupportedError('File I/O is not supported on web platform');
  }

  bool existsSync() {
    throw UnsupportedError('File I/O is not supported on web platform');
  }
}

// Platform stub for web
class Platform {
  static bool get isAndroid => false;
  static bool get isIOS => false;
  static bool get isWindows => false;
  static bool get isMacOS => false;
  static bool get isLinux => false;
  static bool get isWeb => kIsWeb;
}

// Directory stub implementation for web
class Directory {
  final String path;

  Directory(this.path);

  static Directory get systemTemp => Directory('/tmp');

  bool existsSync() {
    throw UnsupportedError('Directory I/O is not supported on web platform');
  }

  Future<bool> exists() async {
    throw UnsupportedError('Directory I/O is not supported on web platform');
  }

  Future<Directory> create({bool recursive = false}) async {
    throw UnsupportedError('Directory I/O is not supported on web platform');
  }
}
