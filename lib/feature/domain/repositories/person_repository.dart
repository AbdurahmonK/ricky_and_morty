import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import 'package:ricky_and_morty/feature/domain/entities/person_entity.dart';

abstract class PersonRepositry {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
