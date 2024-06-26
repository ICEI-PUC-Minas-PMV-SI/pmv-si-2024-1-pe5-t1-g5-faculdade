// lib/services/disciplina_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/disciplina.dart';

class DisciplinaService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080'));

  Future<List<Disciplina>> fetchDisciplinas() async {
    try {
      final response = await _dio.get('/disciplinas');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Disciplina.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load disciplinas');
      }
    } catch (e) {
      print('Error fetching disciplinas: $e');
      throw Exception('Failed to load disciplinas: $e');
    }
  }

  Future<Disciplina> createDisciplina(Disciplina disciplina) async {
    try {
      final response = await _dio.post(
        '/disciplinas',
        data: jsonEncode(disciplina.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Disciplina.fromJson(response.data);
      } else {
        throw Exception('Failed to create disciplina');
      }
    } catch (e) {
      print('Error creating disciplina: $e');
      throw Exception('Failed to create disciplina: $e');
    }
  }

  Future<void> updateDisciplina(int id, Disciplina disciplina) async {
    try {
      final response = await _dio.put(
        '/disciplinas/$id',
        data: jsonEncode(disciplina.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw Exception('Failed to update disciplina');
      }
    } catch (e) {
      print('Error updating disciplina: $e');
      throw Exception('Failed to update disciplina: $e');
    }
  }

  Future<void> deleteDisciplina(int id) async {
    try {
      final response = await _dio.delete('/disciplinas/$id');
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw Exception('Failed to delete disciplina');
      }
    } catch (e) {
      print('Error deleting disciplina: $e');
      throw Exception('Failed to delete disciplina: $e');
    }
  }
}
