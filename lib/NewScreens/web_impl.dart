// Web implementation of image operations
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

/// Converts a web-based image URL to base64
Future<String> getWebImageBase64(String url) async {
  try {
    if (url.startsWith('data:')) {
      // Already a data URL, extract the base64 part
      return url.substring(url.indexOf(',') + 1);
    } else if (url.startsWith('blob:')) {
      // Blob URL, convert to bytes first
      final bytes = await _fetchBlob(url);
      return base64Encode(bytes);
    } else {
      // Regular URL, fetch as blob and convert
      final response = await html.HttpRequest.request(
        url,
        method: 'GET',
        responseType: 'blob',
      );

      final blob = response.response as html.Blob;
      final bytes = await _blobToBytes(blob);
      return base64Encode(bytes);
    }
  } catch (e) {
    print('Error converting web image to base64: $e');
    return '';
  }
}

/// Get bytes from a web image URL (blob, data, or regular URL)
Future<Uint8List> getWebImageBytes(String url) async {
  try {
    if (url.startsWith('data:')) {
      // Data URL - extract the base64 content and convert to bytes
      final base64String = url.substring(url.indexOf(',') + 1);
      return base64Decode(base64String);
    } else if (url.startsWith('blob:')) {
      // Blob URL - fetch and convert to bytes
      return await _fetchBlob(url);
    } else {
      // Regular URL - fetch as blob and convert to bytes
      final response = await html.HttpRequest.request(
        url,
        method: 'GET',
        responseType: 'blob',
      );

      final blob = response.response as html.Blob;
      return await _blobToBytes(blob);
    }
  } catch (e) {
    print('Error getting web image bytes: $e');
    return Uint8List(0);
  }
}

/// Fetch a blob URL and convert to bytes
Future<Uint8List> _fetchBlob(String url) async {
  final completer = Completer<Uint8List>();
  final reader = html.FileReader();

  reader.onLoadEnd.listen((event) {
    final result = reader.result as String;
    final bytes = base64Decode(result.substring(result.indexOf(',') + 1));
    completer.complete(bytes);
  });

  reader.onError.listen((event) {
    completer.completeError('Error reading blob: ${reader.error}');
  });

  // Create an XHR request to get the blob
  final request = html.HttpRequest();
  request.open('GET', url);
  request.responseType = 'blob';

  request.onLoad.listen((_) {
    if (request.status == 200) {
      final blob = request.response as html.Blob;
      reader.readAsDataUrl(blob);
    } else {
      completer.completeError('Failed to load blob: ${request.statusText}');
    }
  });

  request.onError.listen((_) {
    completer.completeError('Error fetching blob: ${request.statusText}');
  });

  request.send();
  return completer.future;
}

/// Convert a blob to bytes
Future<Uint8List> _blobToBytes(html.Blob blob) {
  final completer = Completer<Uint8List>();
  final reader = html.FileReader();

  reader.onLoadEnd.listen((event) {
    final result = reader.result as String;
    final bytes = base64Decode(result.substring(result.indexOf(',') + 1));
    completer.complete(bytes);
  });

  reader.onError.listen((event) {
    completer.completeError('Error reading blob: ${reader.error}');
  });

  reader.readAsDataUrl(blob);
  return completer.future;
}

/// Resize a web image using HTML canvas
Future<Uint8List> resizeWebImage(Uint8List imageData, int targetWidth,
    {int quality = 90}) async {
  final completer = Completer<Uint8List>();

  final img = html.ImageElement();
  final canvas = html.CanvasElement();
  final ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;

  // Create a blob from the image data
  final blob = html.Blob([imageData], 'image/png');
  final url = html.Url.createObjectUrl(blob);

  img.onLoad.listen((_) {
    // Calculate new height to maintain aspect ratio
    final aspectRatio = img.naturalWidth / img.naturalHeight;
    final targetHeight = (targetWidth / aspectRatio).round();

    // Set canvas dimensions
    canvas.width = targetWidth;
    canvas.height = targetHeight;

    // Draw resized image on canvas
    ctx.drawImageScaled(img, 0, 0, targetWidth, targetHeight);

    // Get image data as base64
    final dataUrl = canvas.toDataUrl('image/jpeg', quality / 100);
    final base64 = dataUrl.substring(dataUrl.indexOf(',') + 1);
    final bytes = base64Decode(base64);

    // Clean up
    html.Url.revokeObjectUrl(url);

    completer.complete(bytes);
  });

  img.onError.listen((event) {
    html.Url.revokeObjectUrl(url);
    completer.completeError('Error loading image: ${event.toString()}');
  });

  // Set the source to trigger loading
  img.src = url;

  return completer.future;
}

/// Create a very small JPEG for quick preview or thumbnail
Future<Uint8List> createTinyJpeg(Uint8List imageBytes) async {
  return resizeWebImage(imageBytes, 100, quality: 50);
}
