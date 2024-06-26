// lib/services/curso_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/curso.dart';

class CursoService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080'));

  Future<List<Curso>> fetchCursos() async {
    final response = await _dio.get('/cursos');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      List<dynamic> body = response.data;
      return body.map((dynamic item) => Curso.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cursos');
    }
  }

  Future<Curso> createCurso(Curso curso) async {
    final response = await _dio.post(
      '/cursos',
      data: jsonEncode(curso.toJson()),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return Curso.fromJson(response.data);
    } else {
      throw Exception('Failed to create curso');
    }
  }

  Future<void> updateCurso(int id, Curso curso) async {
    final response = await _dio.put(
      '/cursos/$id',
      data: jsonEncode(curso.toJson()),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
      throw Exception('Failed to update curso');
    }
  }

  Future<void> deleteCurso(int id) async {
    final response = await _dio.delete('/cursos/$id');
    if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
      throw Exception('Failed to delete curso');
    }
  }
}
