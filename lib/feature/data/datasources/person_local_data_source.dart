// ignore_for_file: avoid_print, void_checks

import 'dart:convert';
import '../models/person_model.dart';
import '../../../core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  /// Get the cached [List<PersonModel>] which was gotten ther last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached dadta is present.
  ///
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const cashedPersonsList = 'cashedPersonsList';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences? sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences?.getStringList(cashedPersonsList);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList.map((person) => PersonModel.fromJson(json.decode(person))).toList());
    } else {
      throw CashException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList = persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences?.setStringList(cashedPersonsList, jsonPersonsList);
    print('Persons to write Cache: $jsonPersonsList');
    return Future.value(jsonPersonsList);
  }
}
