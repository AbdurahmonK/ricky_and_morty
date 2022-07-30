import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/platform/network_info.dart';
import 'feature/domain/usecases/search_person.dart';
import 'feature/domain/usecases/get_all_persons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature/domain/repositories/person_repository.dart';
import 'feature/data/repositories/person_repository_impl.dart';
import 'feature/data/datasources/person_local_data_source.dart';
import 'feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'feature/data/datasources/person_remote_data_source.dart';
import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// GetIt sl = GetIt.instance();

Future<void> init() async {
  // BloC/Cubit
  GetIt.instance.registerFactory(() => PersonListCubit(getAllPersons: GetIt.instance()));
  GetIt.instance.registerFactory(() => PersonSearchBloc(searchPerson: GetIt.instance()));
  // sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  // sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // UseCases
  GetIt.instance.registerLazySingleton(() => GetAllPersons(GetIt.instance()));
  GetIt.instance.registerLazySingleton(() => SearchPerson(GetIt.instance()));
  // sl.registerLazySingleton(() => GetAllPersons(sl()));
  // sl.registerLazySingleton(() => SearchPerson(sl()));

  // Repository
  GetIt.instance.registerLazySingleton<PersonRepositry>(() => PersonRepositoryImpl(remoteDataSource: GetIt.instance(), localDataSource: GetIt.instance(), networkInfo: GetIt.instance()));
  GetIt.instance.registerLazySingleton<PersonRemoteDataSource>(() => PersonDataSourceImpl(client: http.Client()));
  GetIt.instance.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImpl(sharedPreferences: GetIt.instance()));
  // sl.registerLazySingleton<PersonRepositry>(() => PersonRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  // sl.registerLazySingleton<PersonRemoteDataSource>(() => PersonDataSourceImpl(client: http.Client()));
  // sl.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  GetIt.instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(GetIt.instance()));
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.instance.registerLazySingleton(() => sharedPreferences);
  GetIt.instance.registerLazySingleton(() => http.Client());
  GetIt.instance.registerLazySingleton(() => InternetConnectionChecker());
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
}
