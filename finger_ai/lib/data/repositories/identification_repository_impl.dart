import 'package:finger_ai/data/models/identification_result.dart';
import 'package:finger_ai/data/network/api_client.dart';
import 'package:finger_ai/domain/repositories/identification_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IdentificationRepository)
class IdentificationRepositoryImpl implements IdentificationRepository {
  final ApiClient _apiClient;

  IdentificationRepositoryImpl(this._apiClient);

  @override
  Future<IdentificationResult> identify(
    String imageBase64,
    int regionModelId,
    int identityModelId,
  ) async {
    try {
      final json = await _apiClient.post('/identify', {
        'image_base64': imageBase64,
        'region_model_id': regionModelId,
        'identity_model_id': identityModelId,
      });
      return IdentificationResult.fromJson(json);
    } catch (e) {
      throw Exception('Error during identification: $e');
    }
  }
}
