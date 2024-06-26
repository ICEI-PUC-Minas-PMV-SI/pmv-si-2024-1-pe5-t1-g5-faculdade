import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/aluno.dart';

class AlunoService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080'));

  Future<List<Aluno>> fetchAlunos() async {
    try {
      final response = await _dio.get('/alunos');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Aluno.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load alunos');
      }
    } catch (e) {
      print('Error fetching alunos: $e');
      throw Exception('Failed to load alunos: $e');
    }
  }

  Future<Aluno> createAluno(Aluno aluno) async {
    try {
      final response = await _dio.post(
        '/alunos',
        data: jsonEncode(aluno.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Aluno.fromJson(response.data);
      } else {
        throw Exception('Failed to create aluno');
      }
    } catch (e) {
      print('Error creating aluno: $e');
      throw Exception('Failed to create aluno: $e');
    }
  }

  Future<void> updateAluno(int id, Aluno aluno) async {
    try {
      final response = await _dio.put(
        '/alunos/$id',
        data: jsonEncode(aluno.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw Exception('Failed to update aluno');
      }
    } catch (e) {
      print('Error updating aluno: $e');
      throw Exception('Failed to update aluno: $e');
    }
  }

  Future<void> deleteAluno(int id) async {
    try {
      final response = await _dio.delete('/alunos/$id');
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        throw Exception('Failed to delete aluno');
      }
    } catch (e) {
      print('Error deleting aluno: $e');
      throw Exception('Failed to delete aluno: $e');
    }
  }
}
