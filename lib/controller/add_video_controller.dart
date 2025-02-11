import 'package:admin_english_app/services/add_video_services.dart';
import 'package:admin_english_app/utils/local_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddVideoController extends ChangeNotifier {
  final AddVideoServices addVideoServices;

  AddVideoController({required this.addVideoServices});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _filePath;
  String? get filePath => _filePath;

  void setFilePath(String? path) {
    _filePath = path;
    notifyListeners();
  }

  Future<void> pickVideo() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.video, allowMultiple: false);

      if (result != null && result.files.isNotEmpty) {
        setFilePath(result.files.single.path);
      }
    } catch (e) {
      throw Exception('Error while pick video file $e');
    }
  }

  Future<void> addVideo(
      {required String filePath,
      required String token,
      required Map<String, dynamic> requestBody}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await addVideoServices.addVideo(
          filePath: filePath, token: token, requestBody: requestBody);
    } catch (e) {
      print('Exception in controller: $e');
      throw Exception('Failed to upload video: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitForm(String title, String description, int videoExp,
      int videoPoin, BuildContext context) async {
    if (_filePath == null) {
      return;
    }

    final requestBody = {
      'title': title,
      'description': description,
      'video_exp': videoExp,
      'video_poin': videoPoin
    };

    final token = await getToken();

    try {
      await addVideo(
          filePath: _filePath!, token: token!, requestBody: requestBody);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video berhasil diunggah!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
