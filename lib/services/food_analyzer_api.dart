import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FoodAnalyzerApi {
  // Multiple possible base URLs (fallbacks)
  static const String primaryUrl = 'https://snap-food.onrender.com';
  static const String fallbackUrl1 = 'https://fitly-food-api.onrender.com';
  static const String fallbackUrl2 = 'https://lehm50.onrender.com';

  // Current active URL (will be determined dynamically)
  static String _activeBaseUrl = primaryUrl;

  // Endpoint for food analysis
  static const String analyzeEndpoint = '/api/analyze-food';

  // Method to analyze a food image with fallbacks
  static Future<Map<String, dynamic>> analyzeFoodImage(
      Uint8List imageBytes) async {
    // List of URLs to try
    final List<String> urlsToTry = [
      _activeBaseUrl, // Try current active URL first
      primaryUrl, // Then primary
      fallbackUrl1, // Then fallback 1
      fallbackUrl2, // Then fallback 2
    ].toSet().toList(); // Remove duplicates

    Exception? lastException;

    // Try each URL until one works
    for (final baseUrl in urlsToTry) {
      try {
        print('Trying API server at: $baseUrl');

        // Convert image bytes to base64
        final String base64Image = base64Encode(imageBytes);
        final String dataUri = 'data:image/jpeg;base64,$base64Image';

        // Call API endpoint
        final response = await http
            .post(
              Uri.parse('$baseUrl$analyzeEndpoint'),
              headers: {
                'Content-Type': 'application/json',
                'Origin': 'https://fitly.app',
              },
              body: jsonEncode({'image': dataUri}),
            )
            .timeout(const Duration(seconds: 30));

        // Check for HTTP errors
        if (response.statusCode != 200) {
          print(
              'API error at $baseUrl: ${response.statusCode}, ${response.body}');
          // Continue to next URL if this one failed
          continue;
        }

        // Parse the response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Check for API-level errors
        if (responseData['success'] != true) {
          print('API returned error: ${responseData['error']}');
          continue;
        }

        // Success! Save this as the active URL for future requests
        if (baseUrl != _activeBaseUrl) {
          print('Updating active API URL to $baseUrl');
          _activeBaseUrl = baseUrl;
        }

        // Return the data
        return responseData['data'];
      } catch (e) {
        print('Error calling $baseUrl: $e');
        lastException = e is Exception ? e : Exception(e.toString());
        // Continue to next URL
      }
    }

    // If we reach here, all URLs failed
    throw lastException ?? Exception('All API servers unreachable');
  }

  // Check if any API server is available
  static Future<bool> checkApiAvailability() async {
    for (final baseUrl in [primaryUrl, fallbackUrl1, fallbackUrl2]) {
      try {
        final response = await http
            .get(Uri.parse(baseUrl))
            .timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          _activeBaseUrl = baseUrl; // Update active URL
          print('API available at $baseUrl');
          return true;
        }
      } catch (e) {
        print('API at $baseUrl unavailable: $e');
      }
    }

    return false;
  }
}
