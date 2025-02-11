import 'dart:convert';

import 'package:admin_english_app/model/add_video_model.dart';
import 'package:admin_english_app/utils/server.dart';
import 'package:http/http.dart' as http;

class AddVideoServices {
  Future<AddVideoModel?> addVideo(
      {required String filePath,
      required String token,
      required Map<String, dynamic> requestBody}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/video-parts'),
      );

      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.fields['request'] = jsonEncode(requestBody);
      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        return AddVideoModel.fromJson(jsonDecode(responseData));
      } else {
        var errorResponse = await response.stream.bytesToString();
        print('Error: ${response.statusCode}, Response: $errorResponse');
        throw Exception('Failed to upload video: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to upload video: $e');
    }
  }
}
