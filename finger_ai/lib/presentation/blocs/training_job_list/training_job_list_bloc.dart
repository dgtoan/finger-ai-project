import 'package:bloc/bloc.dart';
import 'package:finger_ai/domain/repositories/training_repository.dart';
import 'package:finger_ai/presentation/blocs/training_job_list/training_job_list_event.dart';
import 'package:finger_ai/presentation/blocs/training_job_list/training_job_list_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrainingJobListBloc
    extends Bloc<TrainingJobListEvent, TrainingJobListState> {
  final TrainingRepository _repository;

  TrainingJobListBloc(this._repository)
    : super(const TrainingJobListInitial()) {
    on<LoadTrainingJobs>(_onLoadTrainingJobs);
    on<RefreshTrainingJobs>(_onRefreshTrainingJobs);
  }

  Future<void> _onLoadTrainingJobs(
    LoadTrainingJobs event,
    Emitter<TrainingJobListState> emit,
  ) async {
    emit(const TrainingJobListLoading());
    try {
      final jobs = await _repository.getTrainingJobs();
      emit(TrainingJobListLoaded(jobs));
    } catch (e) {
      emit(TrainingJobListError(e.toString()));
    }
  }

  Future<void> _onRefreshTrainingJobs(
    RefreshTrainingJobs event,
    Emitter<TrainingJobListState> emit,
  ) async {
    try {
      final jobs = await _repository.getTrainingJobs();
      emit(TrainingJobListLoaded(jobs));
    } catch (e) {
      emit(TrainingJobListError(e.toString()));
    }
  }
}
