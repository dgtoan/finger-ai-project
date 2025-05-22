import 'package:equatable/equatable.dart';

abstract class ModelListEvent extends Equatable {
  const ModelListEvent();

  @override
  List<Object?> get props => [];
}

class LoadModels extends ModelListEvent {
  const LoadModels();
}

class RefreshModels extends ModelListEvent {
  const RefreshModels();
}
