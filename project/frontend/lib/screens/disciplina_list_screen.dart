// lib/screens/disciplina_list_screen.dart
import 'package:flutter/material.dart';

import '../models/disciplina.dart';
import '../services/disciplina_service.dart';
import 'disciplina_form_screen.dart';

class DisciplinaListScreen extends StatefulWidget {
  @override
  _DisciplinaListScreenState createState() => _DisciplinaListScreenState();
}

class _DisciplinaListScreenState extends State<DisciplinaListScreen> {
  final DisciplinaService _disciplinaService = DisciplinaService();
  late Future<List<Disciplina>> _disciplinas;

  @override
  void initState() {
    super.initState();
    _loadDisciplinas();
  }

  void _loadDisciplinas() {
    setState(() {
      _disciplinas = _disciplinaService.fetchDisciplinas();
    });
  }

  void _navigateToForm({Disciplina? disciplina}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisciplinaFormScreen(disciplina: disciplina),
      ),
    );
    _loadDisciplinas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Disciplina>>(
        future: _disciplinas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load disciplinas: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No disciplinas found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Disciplina disciplina = snapshot.data![index];
                return ListTile(
                  title: Text(disciplina.nome),
                  subtitle: Text(disciplina.descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            _navigateToForm(disciplina: disciplina),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _disciplinaService
                              .deleteDisciplina(disciplina.id);
                          _loadDisciplinas();
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
