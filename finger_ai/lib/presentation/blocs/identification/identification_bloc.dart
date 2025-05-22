import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finger_ai/domain/repositories/identification_repository.dart';
import 'package:finger_ai/domain/repositories/model_repository.dart';
import 'package:finger_ai/presentation/blocs/identification/identification_event.dart';
import 'package:finger_ai/presentation/blocs/identification/identification_state.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

@injectable
class IdentificationBloc
    extends Bloc<IdentificationEvent, IdentificationState> {
  final IdentificationRepository _identificationRepository;
  final ModelRepository _modelRepository;

  IdentificationBloc(this._identificationRepository, this._modelRepository)
    : super(const IdentificationInitial()) {
    on<LoadActiveModels>(_onLoadActiveModels);
    on<PickImage>(_onPickImage);
    on<SetRegionModel>(_onSetRegionModel);
    on<SetIdentityModel>(_onSetIdentityModel);
    on<ProcessImage>(_onProcessImage);
    on<ResetIdentification>(_onResetIdentification);
  }

  Future<void> _onLoadActiveModels(
    LoadActiveModels event,
    Emitter<IdentificationState> emit,
  ) async {
    emit(const LoadingModels());
    try {
      final models = await _modelRepository.getModels();
      final activeModels =
          models.where((model) => model.status == 'active').toList();

      // Tự động chọn model đầu tiên có sẵn từ mỗi loại
      final regionModels =
          activeModels
              .where((model) => model.type.toLowerCase() == 'region')
              .toList();
      final identityModels =
          activeModels
              .where((model) => model.type.toLowerCase() == 'identity')
              .toList();

      final selectedRegionModel =
          regionModels.isNotEmpty ? regionModels.first : null;
      final selectedIdentityModel =
          identityModels.isNotEmpty ? identityModels.first : null;

      emit(
        ModelsLoaded(
          activeModels: activeModels,
          selectedRegionModel: selectedRegionModel,
          selectedIdentityModel: selectedIdentityModel,
        ),
      );
    } catch (e) {
      emit(ModelsLoadingFailure('Failed to load models: $e'));
    }
  }

  Future<void> _onPickImage(
    PickImage event,
    Emitter<IdentificationState> emit,
  ) async {
    if (state is! ModelsLoaded) {
      await _onLoadActiveModels(const LoadActiveModels(), emit);
      if (state is! ModelsLoaded) return;
    }

    final currentState = state as ModelsLoaded;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null &&
          result.files.isNotEmpty &&
          result.files.first.path != null) {
        final file = File(result.files.first.path!);

        // Khi chọn ảnh mới, xóa kết quả nhận diện cũ
        emit(
          currentState.copyWith(
            imageFile: file,
            clearResult: true,
            clearError: true,
            isIdentifying: false,
          ),
        );
      }
    } catch (e) {
      emit(
        currentState.copyWith(
          errorMessage: 'Failed to pick image: $e',
          clearResult: true,
        ),
      );
    }
  }

  void _onSetRegionModel(
    SetRegionModel event,
    Emitter<IdentificationState> emit,
  ) {
    if (state is ModelsLoaded) {
      final currentState = state as ModelsLoaded;
      emit(
        currentState.copyWith(
          selectedRegionModel: event.model,
          clearResult: true,
        ),
      );
    }
  }

  void _onSetIdentityModel(
    SetIdentityModel event,
    Emitter<IdentificationState> emit,
  ) {
    if (state is ModelsLoaded) {
      final currentState = state as ModelsLoaded;
      emit(
        currentState.copyWith(
          selectedIdentityModel: event.model,
          clearResult: true,
        ),
      );
    }
  }

  Future<void> _onProcessImage(
    ProcessImage event,
    Emitter<IdentificationState> emit,
  ) async {
    if (state is! ModelsLoaded) return;

    final currentState = state as ModelsLoaded;

    // Đánh dấu đang xử lý
    emit(
      currentState.copyWith(
        isIdentifying: true,
        clearError: true,
        clearResult: true,
      ),
    );

    try {
      // Convert to base64
      final String base64Image = await _convertImageToBase64(event.imageFile);

      // Call identification API with the selected model IDs
      final result = await _identificationRepository.identify(
        base64Image,
        event.regionModelId,
        event.identityModelId,
      );

      // Cập nhật trạng thái với kết quả nhận diện
      emit(
        currentState.copyWith(
          isIdentifying: false,
          identificationResult: result,
        ),
      );
    } catch (e) {
      // Cập nhật trạng thái lỗi
      emit(
        currentState.copyWith(
          isIdentifying: false,
          errorMessage: 'Identification failed: $e',
        ),
      );
    }
  }

  void _onResetIdentification(
    ResetIdentification event,
    Emitter<IdentificationState> emit,
  ) {
    if (state is ModelsLoaded) {
      final currentState = state as ModelsLoaded;
      emit(currentState.copyWith(clearResult: true, clearError: true));
    } else {
      emit(const IdentificationInitial());
    }
  }

  Future<String> _convertImageToBase64(File imageFile) async {
    // Read the file as bytes
    final bytes = await imageFile.readAsBytes();

    // Process image to reduce size if needed
    final img.Image? image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Could not decode image');
    }

    // Resize image if it's too large
    final img.Image resizedImage = img.copyResize(
      image,
      width: 640, // Reasonable size for API
    );

    // Re-encode as JPEG with reduced quality
    final compressedBytes = img.encodeJpg(resizedImage, quality: 85);

    // Convert to base64
    final base64Image = base64Encode(compressedBytes);
    return base64Image;
  }
}
