import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/auth/data_sources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/auth/data_sources/repositories/auth_repository_imp.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.annonKey,
    url: AppSecrets.url,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      // so it requires the supaseClient, and we already registered it in initDependenies function..
      // it will automatically check what type of instance it want, and its actually wants a supaseclient,
      // so it will locate it automatically and assign it.
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      usersignup: serviceLocator(),
    ),
  );
}
