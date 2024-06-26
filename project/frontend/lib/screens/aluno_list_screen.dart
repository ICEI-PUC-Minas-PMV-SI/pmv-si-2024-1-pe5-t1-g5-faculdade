// lib/screens/aluno_list_screen.dart
import 'package:flutter/material.dart';

import '../models/aluno.dart';
import '../services/aluno_service.dart';
import 'aluno_form_screen.dart';

class AlunoListScreen extends StatefulWidget {
  @override
  _AlunoListScreenState createState() => _AlunoListScreenState();
}

class _AlunoListScreenState extends State<AlunoListScreen> {
  final AlunoService _alunoService = AlunoService();
  late Future<List<Aluno>> _alunos;

  @override
  void initState() {
    super.initState();
    _loadAlunos();
  }

  void _loadAlunos() {
    setState(() {
      _alunos = _alunoService.fetchAlunos();
    });
  }

  void _navigateToForm({Aluno? aluno}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlunoFormScreen(aluno: aluno),
      ),
    );
    _loadAlunos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Aluno>>(
        future: _alunos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load alunos: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No alunos found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Aluno aluno = snapshot.data![index];
                return ListTile(
                  title: Text(aluno.nome),
                  subtitle: Text(aluno.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToForm(aluno: aluno),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _alunoService.deleteAluno(aluno.id);
                          _loadAlunos();
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
