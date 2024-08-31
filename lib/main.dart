import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/theme/apptheme.dart';
import 'package:blog_app/features/auth/data/auth/data_sources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/auth/data_sources/repositories/auth_repository_imp.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.annonKey,
    url: AppSecrets.url,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          usersignup: UserSignUp(
            AuthRepositoryImp(
              AuthRemoteDataSourceImpl(supabase.client),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Apptheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
