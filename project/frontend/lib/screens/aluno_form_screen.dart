// lib/screens/aluno_form_screen.dart
import 'package:flutter/material.dart';

import '../models/aluno.dart';
import '../widgets/aluno_form.dart';

class AlunoFormScreen extends StatelessWidget {
  final Aluno? aluno;

  AlunoFormScreen({this.aluno});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(aluno == null ? 'Criar Aluno' : 'Editar Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            AlunoForm(aluno: aluno, onSave: () => Navigator.pop(context, true)),
      ),
    );
  }
}
