import 'package:finger_ai/data/models/identification_result.dart';

abstract class IdentificationRepository {
  Future<IdentificationResult> identify(
    String imageBase64,
    int regionModelId,
    int identityModelId,
  );
}
