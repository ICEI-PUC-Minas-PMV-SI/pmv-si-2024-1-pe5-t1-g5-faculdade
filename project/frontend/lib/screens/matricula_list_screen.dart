// lib/screens/matricula_list_screen.dart
import 'package:flutter/material.dart';

import '../models/matricula.dart';
import '../services/matricula_service.dart';
import 'matricula_form_screen.dart';

class MatriculaListScreen extends StatefulWidget {
  @override
  _MatriculaListScreenState createState() => _MatriculaListScreenState();
}

class _MatriculaListScreenState extends State<MatriculaListScreen> {
  final MatriculaService _matriculaService = MatriculaService();
  late Future<List<Matricula>> _matriculas;

  @override
  void initState() {
    super.initState();
    _loadMatriculas();
  }

  void _loadMatriculas() {
    setState(() {
      _matriculas = _matriculaService.fetchMatriculas();
    });
  }

  void _navigateToForm({Matricula? matricula}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatriculaFormScreen(matricula: matricula),
      ),
    );
    _loadMatriculas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Matricula>>(
        future: _matriculas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load matriculas: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No matriculas found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Matricula matricula = snapshot.data![index];
                return ListTile(
                  title: Text(
                      'Aluno: ${matricula.aluno.nome}\nDisciplina: ${matricula.disciplina.nome}'),
                  subtitle: Text('Data: ${matricula.dataMatricula}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToForm(matricula: matricula),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _matriculaService.deleteMatricula(matricula.id);
                          _loadMatriculas();
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
