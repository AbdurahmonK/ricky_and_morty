import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ricky_and_morty/common/app_colors.dart';
import 'feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';

import 'feature/presentation/pages/home_page.dart';
import 'locator_service.dart' as di; // import as dependency injection
import 'package:flutter/material.dart';

// import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(create: (context) => GetIt.instance<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(create: (context) => GetIt.instance<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        title: 'Ricky and Morty',
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: const HomePage(),
      ),
    );
  }
}
