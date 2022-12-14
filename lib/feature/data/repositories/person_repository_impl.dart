import 'package:dartz/dartz.dart';
import '../models/person_model.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_info.dart';
import '../../domain/entities/person_entity.dart';
import '../../domain/repositories/person_repository.dart';
import '../../data/datasources/person_local_data_source.dart';
import '../../data/datasources/person_remote_data_source.dart';

class PersonRepositoryImpl implements PersonRepositry {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CashException {
        return Left(CacheFailure());
      }
    }
  }
}
