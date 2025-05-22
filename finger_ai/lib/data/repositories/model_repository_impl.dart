import 'package:finger_ai/data/models/model_update_data.dart';
import 'package:finger_ai/data/models/trained_model.dart';
import 'package:finger_ai/data/network/api_client.dart';
import 'package:finger_ai/domain/repositories/model_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ModelRepository)
class ModelRepositoryImpl implements ModelRepository {
  final ApiClient _apiClient;

  ModelRepositoryImpl(this._apiClient);

  @override
  Future<List<TrainedModel>> getModels() async {
    try {
      final jsonList = await _apiClient.getList('/models');
      return jsonList.map((json) => TrainedModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching models: $e');
    }
  }

  @override
  Future<TrainedModel> getModelDetail(int modelId) async {
    try {
      final json = await _apiClient.get('/models/$modelId');
      return TrainedModel.fromJson(json);
    } catch (e) {
      throw Exception('Error fetching model details: $e');
    }
  }

  @override
  Future<TrainedModel> updateModel(int modelId, ModelUpdateData data) async {
    try {
      final jsonData = data.toJson();
      final json = await _apiClient.patch('/models/$modelId', jsonData);
      return TrainedModel.fromJson(json);
    } catch (e) {
      throw Exception('Error updating model: $e');
    }
  }

  @override
  Future<void> deleteModel(int modelId) async {
    try {
      await _apiClient.delete('/models/$modelId');
    } catch (e) {
      throw Exception('Error deleting model: $e');
    }
  }
}
