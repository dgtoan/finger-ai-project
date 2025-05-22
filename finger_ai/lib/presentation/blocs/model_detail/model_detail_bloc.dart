import 'package:bloc/bloc.dart';
import 'package:finger_ai/domain/repositories/model_repository.dart';
import 'package:finger_ai/presentation/blocs/model_detail/model_detail_event.dart';
import 'package:finger_ai/presentation/blocs/model_detail/model_detail_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ModelDetailBloc extends Bloc<ModelDetailEvent, ModelDetailState> {
  final ModelRepository _repository;

  ModelDetailBloc(this._repository) : super(const ModelDetailInitial()) {
    on<LoadModelDetail>(_onLoadModelDetail);
    on<UpdateModel>(_onUpdateModel);
    on<DeleteModel>(_onDeleteModel);
  }

  Future<void> _onLoadModelDetail(
    LoadModelDetail event,
    Emitter<ModelDetailState> emit,
  ) async {
    emit(const ModelDetailLoading());
    try {
      final model = await _repository.getModelDetail(event.id);
      emit(ModelDetailLoaded(model));
    } catch (e) {
      emit(ModelDetailError(e.toString()));
    }
  }

  Future<void> _onUpdateModel(
    UpdateModel event,
    Emitter<ModelDetailState> emit,
  ) async {
    emit(const ModelDetailUpdating());
    try {
      final updatedModel = await _repository.updateModel(event.id, event.data);
      emit(ModelDetailUpdateSuccess(updatedModel));
    } catch (e) {
      emit(ModelDetailError(e.toString()));
    }
  }

  Future<void> _onDeleteModel(
    DeleteModel event,
    Emitter<ModelDetailState> emit,
  ) async {
    emit(const ModelDetailDeleting());
    try {
      await _repository.deleteModel(event.id);
      emit(const ModelDetailDeleteSuccess());
    } catch (e) {
      emit(ModelDetailError(e.toString()));
    }
  }
}
