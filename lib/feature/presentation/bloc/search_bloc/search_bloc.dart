// ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_and_morty/core/error/failure.dart';
import 'package:ricky_and_morty/feature/domain/usecases/search_person.dart';
import 'package:ricky_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:ricky_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());

      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery));
      emit(
        failureOrPerson.fold((failure) => PersonSearchError(message: _mapFailureToMessage(failure)), (person) => PersonSearchLoaded(persons: person)),
      );
    });
  }

  // Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
  //   if (event is SearchPersons) {
  //     yield* _mapFetchPersonsToState(event.personQuery);
  //   }
  // }

  // Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
  //   yield PersonSearchLoading();

  //   final failureOrPerson = await searchPerson(SearchPersonParams(query: personQuery));

  //   yield* failureOrPerson.fold((failure) => PersonSearchError(message: _mapFailureToMessage(failure)), (person) => PersonSearchLoaded(persons: person));
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
