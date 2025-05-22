import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class NewTrainingJobEvent extends Equatable {
  const NewTrainingJobEvent();

  @override
  List<Object?> get props => [];
}

class SubmitTrainingJob extends NewTrainingJobEvent {
  final String type;
  final File file;
  final String configJson;

  const SubmitTrainingJob({
    required this.type,
    required this.file,
    required this.configJson,
  });

  @override
  List<Object?> get props => [type, file, configJson];
}
