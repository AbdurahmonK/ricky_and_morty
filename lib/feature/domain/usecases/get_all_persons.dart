import 'package:dartz/dartz.dart';
import '../entities/person_entity.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepositry personRepositry;

  GetAllPersons(this.personRepositry);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParams params) async {
    return await personRepositry.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object> get props => [page];
}
