// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import 'data/network/api_client.dart' as _i599;
import 'data/repositories/identification_repository_impl.dart' as _i630;
import 'data/repositories/model_repository_impl.dart' as _i218;
import 'data/repositories/training_repository_impl.dart' as _i976;
import 'domain/repositories/identification_repository.dart' as _i206;
import 'domain/repositories/model_repository.dart' as _i267;
import 'domain/repositories/training_repository.dart' as _i803;
import 'injection.dart' as _i464;
import 'presentation/blocs/identification/identification_bloc.dart' as _i614;
import 'presentation/blocs/model_detail/model_detail_bloc.dart' as _i361;
import 'presentation/blocs/model_list/model_list_bloc.dart' as _i880;
import 'presentation/blocs/new_training_job/new_training_job_bloc.dart' as _i83;
import 'presentation/blocs/training_job_list/training_job_list_bloc.dart'
    as _i163;
import 'services/image_service.dart' as _i958;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i958.ImageService>(() => _i958.ImageService());
  gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
  gh.lazySingleton<_i599.ApiClient>(() => _i599.ApiClient(gh<_i519.Client>()));
  gh.lazySingleton<_i267.ModelRepository>(
    () => _i218.ModelRepositoryImpl(gh<_i599.ApiClient>()),
  );
  gh.lazySingleton<_i206.IdentificationRepository>(
    () => _i630.IdentificationRepositoryImpl(gh<_i599.ApiClient>()),
  );
  gh.lazySingleton<_i803.TrainingRepository>(
    () => _i976.TrainingRepositoryImpl(gh<_i599.ApiClient>()),
  );
  gh.factory<_i614.IdentificationBloc>(
    () => _i614.IdentificationBloc(
      gh<_i206.IdentificationRepository>(),
      gh<_i267.ModelRepository>(),
    ),
  );
  gh.factory<_i880.ModelListBloc>(
    () => _i880.ModelListBloc(gh<_i267.ModelRepository>()),
  );
  gh.factory<_i361.ModelDetailBloc>(
    () => _i361.ModelDetailBloc(gh<_i267.ModelRepository>()),
  );
  gh.factory<_i163.TrainingJobListBloc>(
    () => _i163.TrainingJobListBloc(gh<_i803.TrainingRepository>()),
  );
  gh.factory<_i83.NewTrainingJobBloc>(
    () => _i83.NewTrainingJobBloc(gh<_i803.TrainingRepository>()),
  );
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
