import 'package:bloc/bloc.dart';
import 'package:finger_ai/domain/repositories/training_repository.dart';
import 'package:finger_ai/presentation/blocs/new_training_job/new_training_job_event.dart';
import 'package:finger_ai/presentation/blocs/new_training_job/new_training_job_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewTrainingJobBloc
    extends Bloc<NewTrainingJobEvent, NewTrainingJobState> {
  final TrainingRepository _repository;

  NewTrainingJobBloc(this._repository) : super(const NewTrainingJobInitial()) {
    on<SubmitTrainingJob>(_onSubmitTrainingJob);
  }

  Future<void> _onSubmitTrainingJob(
    SubmitTrainingJob event,
    Emitter<NewTrainingJobState> emit,
  ) async {
    emit(const NewTrainingJobSubmitting());
    try {
      final job = await _repository.startTrainingJob(
        modelType: event.type,
        dataFile: event.file,
        configParamsJson: event.configJson,
      );
      emit(NewTrainingJobSuccess(job));
    } catch (e) {
      emit(NewTrainingJobFailure(e.toString()));
    }
  }
}
