import 'dart:io';

import 'package:finger_ai/data/models/training_job.dart';

abstract class TrainingRepository {
  Future<List<TrainingJob>> getTrainingJobs();

  Future<TrainingJob> getTrainingJobDetail(int jobId);

  Future<TrainingJob> startTrainingJob({
    required String modelType,
    required File dataFile,
    required String configParamsJson,
  });
}
