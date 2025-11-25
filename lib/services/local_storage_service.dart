import 'package:shared_preferences/shared_preferences.dart';
import 'package:resume_builder_app_github/models/person.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class LocalStorageService {
  static const String _resumesKey = 'saved_resumes';
  
  // Save a list of resumes to local storage
  static Future<void> saveResumes(List<Person> resumes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> serializedResumes = resumes.map((resume) => jsonEncode({
        'name': resume.name,
        'description': resume.description,
        'hobby': resume.hobby,
        'contacts': resume.contacts,
        'githubUsername': resume.githubUsername,
      })).toList();
      
      await prefs.setStringList(_resumesKey, serializedResumes);
      
      // For web, we need to explicitly persist the data
      if (kIsWeb) {
        await prefs.reload();
      }
    } catch (e) {
      print('Error saving resumes: $e');
      // Re-throw the error to be handled by the caller
      rethrow;
    }
  }
  
  // Load resumes from local storage
  static Future<List<Person>> loadResumes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // For web, ensure we have the latest data
      if (kIsWeb) {
        await prefs.reload();
      }
      
      final List<String>? serializedResumes = prefs.getStringList(_resumesKey);
      
      if (serializedResumes == null) return [];
      
      return serializedResumes.map((resume) {
        try {
          final Map<String, dynamic> data = jsonDecode(resume);
          return Person(
            name: data['name'] ?? '',
            description: data['description'] ?? '',
            hobby: data['hobby'] ?? '',
            contacts: data['contacts'] ?? '',
            githubUsername: data['githubUsername'] ?? '',
          );
        } catch (e) {
          print('Error parsing resume: $e');
          return null;
        }
      }).whereType<Person>().toList();
    } catch (e) {
      print('Error loading resumes: $e');
      return [];
    }
  }
  
  // Add a single resume
  static Future<void> addResume(Person resume) async {
    try {
      final List<Person> resumes = await loadResumes();
      resumes.add(resume);
      await saveResumes(resumes);
    } catch (e) {
      print('Error adding resume: $e');
      rethrow;
    }
  }
  
  // Delete a resume by index
  static Future<void> deleteResume(int index) async {
    try {
      final List<Person> resumes = await loadResumes();
      if (index >= 0 && index < resumes.length) {
        resumes.removeAt(index);
        await saveResumes(resumes);
      }
    } catch (e) {
      print('Error deleting resume: $e');
      rethrow;
    }
  }
}
