import '../models/person.dart';
import '../services/local_storage_service.dart';
import 'dart:developer' as developer;

class PersonRepository {
  List<Person> _people = [];
  bool _isInitialized = false;
  bool _hasError = false;

  // Initialize repository by loading saved resumes
  Future<void> _ensureInitialized() async {
    if (!_isInitialized && !_hasError) {
      try {
        _people = await LocalStorageService.loadResumes();
        
        // Add default resumes if no saved resumes exist
        if (_people.isEmpty) {
          _people = [
            Person(
              name: 'Alex',
              description: 'Software developer at EPAM',
              hobby: 'Gaming, music, and Flutter',
              contacts: 'alex@gmail.com',
              githubUsername: 'alex-sample',
            ),
            Person(
              name: 'Yana',
              description: 'Designer at Naughty Dog',
              hobby: 'Drawing, storytelling, and travel',
              contacts: 'yana@example.com',
              githubUsername: 'happymary16',
            ),
          ];
          await LocalStorageService.saveResumes(_people);
        }
        
        _isInitialized = true;
      } catch (e) {
        _hasError = true;
        developer.log('Error initializing PersonRepository: $e', error: e);
        rethrow;
      }
    }
  }

  Future<List<Person>> getAll() async {
    try {
      await _ensureInitialized();
      return List<Person>.from(_people);
    } catch (e) {
      developer.log('Error getting all resumes: $e', error: e);
      return [];
    }
  }

  Future<void> add(Person person) async {
    try {
      await _ensureInitialized();
      _people.add(person);
      await LocalStorageService.saveResumes(_people);
    } catch (e) {
      developer.log('Error adding resume: $e', error: e);
      rethrow;
    }
  }

  Future<void> duplicate(Person person) async {
    try {
      await _ensureInitialized();
      _people.add(person);
      await LocalStorageService.saveResumes(_people);
    } catch (e) {
      developer.log('Error duplicating resume: $e', error: e);
      rethrow;
    }
  }
  
  Future<void> removeAt(int index) async {
    try {
      await _ensureInitialized();
      if (index >= 0 && index < _people.length) {
        _people.removeAt(index);
        await LocalStorageService.saveResumes(_people);
      }
    } catch (e) {
      developer.log('Error removing resume at index $index: $e', error: e);
      rethrow;
    }
  }
}
