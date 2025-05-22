import 'dart:io';

import 'package:finger_ai/data/models/training_job.dart';
import 'package:finger_ai/data/network/api_client.dart';
import 'package:finger_ai/domain/repositories/training_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TrainingRepository)
class TrainingRepositoryImpl implements TrainingRepository {
  final ApiClient _apiClient;

  TrainingRepositoryImpl(this._apiClient);

  @override
  Future<List<TrainingJob>> getTrainingJobs() async {
    try {
      final jsonList = await _apiClient.getList('/training/jobs');
      return jsonList.map((json) => TrainingJob.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching training jobs: $e');
    }
  }

  @override
  Future<TrainingJob> getTrainingJobDetail(int jobId) async {
    try {
      final json = await _apiClient.get('/training/jobs/$jobId');
      return TrainingJob.fromJson(json);
    } catch (e) {
      throw Exception('Error fetching job details: $e');
    }
  }

  @override
  Future<TrainingJob> startTrainingJob({
    required String modelType,
    required File dataFile,
    required String configParamsJson,
  }) async {
    try {
      final json = await _apiClient.uploadFile(
        '/training/$modelType',
        dataFile,
        'data_file',
        additionalFields: {'config_params_json': configParamsJson},
      );
      return TrainingJob.fromJson(json);
    } catch (e) {
      throw Exception('Error starting training job: $e');
    }
  }
}
