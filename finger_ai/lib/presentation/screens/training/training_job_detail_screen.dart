import 'dart:convert';
import 'package:finger_ai/data/models/training_job.dart';
import 'package:finger_ai/domain/repositories/training_repository.dart';
import 'package:finger_ai/injection.dart';
import 'package:finger_ai/presentation/widgets/error_display_widget.dart';
import 'package:finger_ai/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrainingJobDetailScreen extends StatefulWidget {
  final String jobId;

  const TrainingJobDetailScreen({super.key, required this.jobId});

  @override
  State<TrainingJobDetailScreen> createState() =>
      _TrainingJobDetailScreenState();
}

class _TrainingJobDetailScreenState extends State<TrainingJobDetailScreen> {
  late Future<TrainingJob> _jobFuture;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy HH:mm:ss');

  @override
  void initState() {
    super.initState();
    _loadJobDetails();
  }

  void _loadJobDetails() {
    final trainingRepository = getIt<TrainingRepository>();
    _jobFuture = trainingRepository.getTrainingJobDetail(
      int.parse(widget.jobId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _loadJobDetails();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<TrainingJob>(
        future: _jobFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return ErrorDisplayWidget(
              message: 'Failed to load job details: ${snapshot.error}',
              onRetry: () {
                setState(() {
                  _loadJobDetails();
                });
              },
            );
          } else if (snapshot.hasData) {
            final job = snapshot.data!;
            return _buildJobDetails(job);
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildJobDetails(TrainingJob job) {
    // Determine status color
    Color statusColor;
    IconData statusIcon;

    switch (job.status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'running':
        statusColor = Colors.blue;
        statusIcon = Icons.sync;
        break;
      case 'failed':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with ID and Status
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Job #${job.id}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, color: statusColor, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              job.status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Model Type
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              job.modelType.toLowerCase() == 'region'
                                  ? Colors.purple.withOpacity(0.1)
                                  : Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                job.modelType.toLowerCase() == 'region'
                                    ? Colors.purple
                                    : Colors.blue,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              job.modelType.toLowerCase() == 'region'
                                  ? Icons.grid_3x3
                                  : Icons.fingerprint,
                              color:
                                  job.modelType.toLowerCase() == 'region'
                                      ? Colors.purple
                                      : Colors.blue,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${job.modelType} Model',
                              style: TextStyle(
                                color:
                                    job.modelType.toLowerCase() == 'region'
                                        ? Colors.purple
                                        : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Dates Information
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
                    'Timeline',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineItem(
                    icon: Icons.add_circle,
                    title: 'Created',
                    timestamp: job.createdAt,
                    color: Colors.green,
                  ),
                  if (job.startedAt != null)
                    _buildTimelineItem(
                      icon: Icons.play_circle,
                      title: 'Started',
                      timestamp: job.startedAt!,
                      color: Colors.blue,
                    ),
                  if (job.completedAt != null)
                    _buildTimelineItem(
                      icon:
                          job.status.toLowerCase() == 'completed'
                              ? Icons.check_circle
                              : Icons.error,
                      title:
                          job.status.toLowerCase() == 'completed'
                              ? 'Completed'
                              : 'Failed',
                      timestamp: job.completedAt!,
                      color:
                          job.status.toLowerCase() == 'completed'
                              ? Colors.green
                              : Colors.red,
                      isLast: true,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // File Information
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
                    'Data File',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.insert_drive_file,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(job.originalFilename ?? 'No filename'),
                    subtitle: Text('Path: ${job.uploadedDataPath}'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Configuration Parameters
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
                    'Configuration Parameters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (job.configParams.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Text(
                        _formatJson(job.configParams),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    )
                  else
                    const Text('No configuration parameters available'),
                ],
              ),
            ),
          ),

          // Error Message (if available)
          if (job.errorMessage != null) ...[
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Error Message',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: Text(job.errorMessage!),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required DateTime timestamp,
    required Color color,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: Colors.grey.withOpacity(0.5),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  _dateFormat.format(timestamp),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }
}
