// lib/screens/curso_list_screen.dart
import 'package:flutter/material.dart';

import '../models/curso.dart';
import '../services/curso_service.dart';
import 'curso_form_screen.dart';

class CursoListScreen extends StatefulWidget {
  @override
  _CursoListScreenState createState() => _CursoListScreenState();
}

class _CursoListScreenState extends State<CursoListScreen> {
  final CursoService _cursoService = CursoService();
  late Future<List<Curso>> _cursos;

  @override
  void initState() {
    super.initState();
    _loadCursos();
  }

  void _loadCursos() {
    setState(() {
      _cursos = _cursoService.fetchCursos();
    });
  }

  void _navigateToForm({Curso? curso}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CursoFormScreen(curso: curso),
      ),
    );
    _loadCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Curso>>(
        future: _cursos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load cursos: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cursos found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Curso curso = snapshot.data![index];
                return ListTile(
                  title: Text(curso.nome),
                  subtitle: Text(curso.descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToForm(curso: curso),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _cursoService.deleteCurso(curso.id);
                          _loadCursos();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
