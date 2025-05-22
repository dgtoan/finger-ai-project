import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finger_ai/injection.dart';
import 'package:finger_ai/presentation/blocs/new_training_job/new_training_job_bloc.dart';
import 'package:finger_ai/presentation/blocs/new_training_job/new_training_job_event.dart';
import 'package:finger_ai/presentation/blocs/new_training_job/new_training_job_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewTrainingJobScreen extends StatefulWidget {
  const NewTrainingJobScreen({super.key});

  @override
  State<NewTrainingJobScreen> createState() => _NewTrainingJobScreenState();
}

class _NewTrainingJobScreenState extends State<NewTrainingJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedModelType = 'identity';
  final _configController = TextEditingController(
    text:
        '{\n  "epochs": 50,\n  "batch_size": 16,\n  "img_size": 640,\n  "model_base": "yolo11n.pt"\n}',
  );
  File? _selectedFile;
  String? _selectedFileName;
  bool _isLoading = false;

  @override
  void dispose() {
    _configController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _selectedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewTrainingJobBloc>(),
      child: BlocConsumer<NewTrainingJobBloc, NewTrainingJobState>(
        listener: (context, state) {
          if (state is NewTrainingJobSubmitting) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is NewTrainingJobSuccess) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Training job created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          } else if (state is NewTrainingJobFailure) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('New Training Job')),
            body:
                _isLoading
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Creating training job...'),
                        ],
                      ),
                    )
                    : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Model Type Selection
                            const Text(
                              'Model Type',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RadioListTile<String>(
                                      title: const Row(
                                        children: [
                                          Icon(
                                            Icons.fingerprint,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: 8),
                                          Text('Identity Model'),
                                        ],
                                      ),
                                      subtitle: const Text(
                                        'For identifying specific individuals',
                                      ),
                                      value: 'identity',
                                      groupValue: _selectedModelType,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedModelType = value;
                                          });
                                        }
                                      },
                                    ),
                                    RadioListTile<String>(
                                      title: const Row(
                                        children: [
                                          Icon(
                                            Icons.grid_3x3,
                                            color: Colors.purple,
                                          ),
                                          SizedBox(width: 8),
                                          Text('Region Model'),
                                        ],
                                      ),
                                      subtitle: const Text(
                                        'For detecting fingerprint regions',
                                      ),
                                      value: 'region',
                                      groupValue: _selectedModelType,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedModelType = value;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // File Upload
                            const Text(
                              'Training Data',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Upload a dataset file to train your model',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 16),
                                    if (_selectedFileName != null)
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.blue.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.insert_drive_file,
                                              color: Colors.blue,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                _selectedFileName!,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                size: 16,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _selectedFile = null;
                                                  _selectedFileName = null;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: _pickFile,
                                        icon: const Icon(Icons.upload_file),
                                        label: Text(
                                          _selectedFileName == null
                                              ? 'Select File'
                                              : 'Change File',
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Configuration JSON
                            const Text(
                              'Configuration Parameters',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Enter training configuration parameters in JSON format',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _configController,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText:
                                            '{\n  "epochs": 50,\n  "batch_size": 16,\n  "img_size": 640,\n  "model_base": "yolo11n.pt"\n}',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.withOpacity(0.1),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter configuration parameters';
                                        }

                                        // Validate JSON format
                                        try {
                                          jsonDecode(value);
                                        } catch (e) {
                                          return 'Invalid JSON format';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_selectedFile == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please select a file'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<NewTrainingJobBloc>().add(
                                      SubmitTrainingJob(
                                        type: _selectedModelType,
                                        file: _selectedFile!,
                                        configJson: _configController.text,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Start Training Job',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          );
        },
      ),
    );
  }
}
