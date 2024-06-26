// lib/services/matricula_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/matricula.dart';

class MatriculaService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080'));

  Future<List<Matricula>> fetchMatriculas() async {
    final response = await _dio.get('/matriculas');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<dynamic> body = response.data;
      return body.map((dynamic item) => Matricula.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load matriculas');
    }
  }

  Future<Matricula> createMatricula(Matricula matricula) async {
    final response = await _dio.post(
      '/matriculas',
      data: jsonEncode(matricula.toJson()),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return Matricula.fromJson(response.data);
    } else {
      throw Exception('Failed to create matricula');
    }
  }

  Future<void> updateMatricula(int id, Matricula matricula) async {
    final response = await _dio.put(
      '/matriculas/$id',
      data: jsonEncode(matricula.toJson()),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
      throw Exception('Failed to update matricula');
    }
  }

  Future<void> deleteMatricula(int id) async {
    final response = await _dio.delete('/matriculas/$id');
    if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
      throw Exception('Failed to delete matricula');
    }
  }
}
