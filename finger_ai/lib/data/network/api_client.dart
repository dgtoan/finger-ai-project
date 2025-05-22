import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  final http.Client _httpClient;
  final String baseUrl =
      'http://localhost:8000'; // Change this to your actual backend URL

  ApiClient(this._httpClient);

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _httpClient.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      final responseMap = _processResponse(response);
      print(' Get Response: $responseMap');
      return responseMap;
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  Future<List<dynamic>> getList(String endpoint) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _httpClient.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseMap = json.decode(response.body);
        print(' Get List Response: $responseMap');
        return responseMap as List<dynamic>;
      } else {
        throw Exception(
          'Request failed with status: ${response.statusCode}. '
          'Message: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('GET list request failed: $e');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final responseMap = _processResponse(response);
      print(' Post Response: $responseMap');
      return responseMap;
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _httpClient.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final responseMap = _processResponse(response);
      print(' Patch Response: $responseMap');
      return responseMap;
    } catch (e) {
      throw Exception('PATCH request failed: $e');
    }
  }

  Future<void> delete(String endpoint) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _httpClient.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
          'Request failed with status: ${response.statusCode}. '
          'Message: ${response.body}',
        );
      }

      print(' Delete Response: ${response.body}');
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  Future<Map<String, dynamic>> uploadFile(
    String endpoint,
    File file,
    String fieldName, {
    Map<String, String>? additionalFields,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endpoint'),
      );

      // Add the file to the request
      request.files.add(
        http.MultipartFile(
          fieldName,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );

      // Add additional fields if provided
      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final responseMap = _processResponse(response);
      print(' Upload File Response: $responseMap');
      return responseMap;
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return json.decode(response.body);
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}. '
        'Message: ${response.body}',
      );
    }
  }
}
