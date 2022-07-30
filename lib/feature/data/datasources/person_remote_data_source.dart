// ignore_for_file: avoid_print

import 'dart:convert';
import '../models/person_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/error/exception.dart';

abstract class PersonRemoteDataSource {
  /// Calls the https://rickandmortyapi.com/api/character/?page=1 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PersonModel>> getAllPersons(int page);

  /// Calls the https://rickandmortyapi.com/api/character/?name=Morty endpoint.
  ///
  /// Thrpws a [ServerException] for all error codes.
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonDataSourceImpl implements PersonRemoteDataSource {
  final http.Client? client;

  PersonDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=$page');
  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final res = await client?.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (res?.statusCode == 200) {
      final persons = json.decode(res!.body);
      return (persons['results'] as List).map((person) => PersonModel.fromJson(person)).toList();
    } else {
      throw ServerException();
    }
  }
}
