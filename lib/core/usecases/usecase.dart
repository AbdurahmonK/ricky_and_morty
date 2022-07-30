import 'package:dartz/dartz.dart';
import 'package:ricky_and_morty/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}