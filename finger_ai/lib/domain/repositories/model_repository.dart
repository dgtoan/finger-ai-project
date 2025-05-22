import 'package:finger_ai/data/models/model_update_data.dart';
import 'package:finger_ai/data/models/trained_model.dart';

abstract class ModelRepository {
  Future<List<TrainedModel>> getModels();

  Future<TrainedModel> getModelDetail(int modelId);

  Future<TrainedModel> updateModel(int modelId, ModelUpdateData data);

  Future<void> deleteModel(int modelId);
}
