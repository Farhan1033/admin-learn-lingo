import 'package:admin_english_app/controller/add_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoExpController = TextEditingController();
  final _videoPoinController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoExpController.dispose();
    _videoPoinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Video Baru'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitleField(),
              const SizedBox(height: 16),
              _buildDescriptionField(),
              const SizedBox(height: 16),
              _buildVideoExpField(),
              const SizedBox(height: 16),
              _buildVideoPoinField(),
              const SizedBox(height: 24),
              _buildFilePickerSection(context),
              const SizedBox(height: 32),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Judul Video',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Judul harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Deskripsi Video',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  Widget _buildVideoExpField() {
    return TextFormField(
      controller: _videoExpController,
      decoration: const InputDecoration(
        labelText: 'XP Video',
        border: OutlineInputBorder(),
        suffixText: 'XP',
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'XP harus diisi';
        }
        if (int.tryParse(value) == null) {
          return 'Masukkan angka yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildVideoPoinField() {
    return TextFormField(
      controller: _videoPoinController,
      decoration: const InputDecoration(
        labelText: 'Poin Video',
        border: OutlineInputBorder(),
        suffixText: 'Poin',
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Poin harus diisi';
        }
        if (int.tryParse(value) == null) {
          return 'Masukkan angka yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildFilePickerSection(BuildContext context) {
    return Consumer<AddVideoController>(
      builder: (context, controller, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.video_library),
              label: const Text('Pilih File Video'),
              onPressed: controller.isLoading ? null : controller.pickVideo,
            ),
            if (controller.filePath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'File dipilih: ${controller.filePath!.split('/').last}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Consumer<AddVideoController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            final videoExp = int.parse(_videoExpController.text);
            final videoPoin = int.parse(_videoPoinController.text);
            if (_formKey.currentState!.validate()) {
              controller.submitForm(
                _titleController.text,
                _descriptionController.text,
                videoExp,
                videoPoin,
                context,
              );
            }
          },
          child: const Text('UPLOAD VIDEO', style: TextStyle(fontSize: 16)),
        );
      },
    );
  }

  void _submitForm(AddVideoController controller) {
    final videoExp = int.parse(_videoExpController.text);
    final videoPoin = int.parse(_videoPoinController.text);

    controller.submitForm(
      _titleController.text,
      _descriptionController.text,
      videoExp,
      videoPoin,
      context,
    );

    // Reset form setelah submit
    if (controller.filePath != null && !controller.isLoading) {
      _formKey.currentState!.reset();
      controller.setFilePath(null);
    }
  }
}
