import 'package:finger_ai/data/models/trained_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ModelListTile extends StatelessWidget {
  final TrainedModel model;
  final VoidCallback? onBackFromDetail;

  const ModelListTile({super.key, required this.model, this.onBackFromDetail});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    // Determine status indicator
    Color statusColor =
        model.status.toLowerCase() == 'active' ? Colors.green : Colors.grey;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          await context.push('/models/${model.id}');
          if (context.mounted) {
            onBackFromDetail?.call();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Model Name
                  Expanded(
                    child: Text(
                      model.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Status Indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      model.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Model type and ID
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          model.type.toLowerCase() == 'region'
                              ? Colors.purple[100]
                              : Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      model.type,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            model.type.toLowerCase() == 'region'
                                ? Colors.purple[800]
                                : Colors.blue[800],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ID: ${model.id}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Metrics (accuracy and loss)
              if (model.modelAccuracy != null || model.modelLoss != null)
                Row(
                  children: [
                    if (model.modelAccuracy != null) ...[
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.green[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Accuracy: ${(model.modelAccuracy! * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    if (model.modelLoss != null) ...[
                      Icon(
                        Icons.show_chart,
                        size: 16,
                        color: Colors.orange[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Loss: ${model.modelLoss!.toStringAsFixed(4)}',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),

              const SizedBox(height: 8),

              // Created date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Created: ${dateFormat.format(model.createdAt)}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  // Training Job ID if available
                  if (model.trainingJobId != null)
                    Row(
                      children: [
                        const Icon(Icons.source, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Job #${model.trainingJobId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
