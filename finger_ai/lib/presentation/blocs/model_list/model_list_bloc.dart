import 'package:bloc/bloc.dart';
import 'package:finger_ai/domain/repositories/model_repository.dart';
import 'package:finger_ai/presentation/blocs/model_list/model_list_event.dart';
import 'package:finger_ai/presentation/blocs/model_list/model_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ModelListBloc extends Bloc<ModelListEvent, ModelListState> {
  final ModelRepository _repository;

  ModelListBloc(this._repository) : super(const ModelListInitial()) {
    on<LoadModels>(_onLoadModels);
    on<RefreshModels>(_onRefreshModels);
  }

  Future<void> _onLoadModels(
    LoadModels event,
    Emitter<ModelListState> emit,
  ) async {
    emit(const ModelListLoading());
    try {
      final models = await _repository.getModels();
      emit(ModelListLoaded(models));
    } catch (e) {
      emit(ModelListError(e.toString()));
    }
  }

  Future<void> _onRefreshModels(
    RefreshModels event,
    Emitter<ModelListState> emit,
  ) async {
    try {
      final models = await _repository.getModels();
      emit(ModelListLoaded(models));
    } catch (e) {
      emit(ModelListError(e.toString()));
    }
  }
}
