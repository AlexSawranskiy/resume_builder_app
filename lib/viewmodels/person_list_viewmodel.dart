import 'package:flutter/material.dart';
import '../models/person.dart';
import '../repository/person_repository.dart';

class PersonListViewModel extends ChangeNotifier {
  final PersonRepository _repository;
  bool _isLoading = true;
  List<Person> _people = [];
  String? _error;

  PersonListViewModel(this._repository) {
    _loadPeople();
  }

  bool get isLoading => _isLoading;
  List<Person> get people => List<Person>.from(_people);
  String? get error => _error;

  Future<void> _loadPeople() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _people = await _repository.getAll();
      _error = null;
    } catch (e) {
      _error = 'Failed to load resumes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPerson(Person person) async {
    try {
      await _repository.add(person);
      await _loadPeople(); // Reload the list to ensure consistency
    } catch (e) {
      _error = 'Failed to add resume: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> duplicatePerson(Person person) async {
    try {
      await _repository.duplicate(person);
      await _loadPeople(); // Reload the list to ensure consistency
    } catch (e) {
      _error = 'Failed to duplicate resume: $e';
      notifyListeners();
      rethrow;
    }
  }
  
  Future<void> deletePerson(int index) async {
    try {
      await _repository.removeAt(index);
      await _loadPeople(); // Reload the list to ensure consistency
    } catch (e) {
      _error = 'Failed to delete resume: $e';
      notifyListeners();
      rethrow;
    }
  }
}
