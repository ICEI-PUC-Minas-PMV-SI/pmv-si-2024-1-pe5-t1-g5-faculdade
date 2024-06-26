// lib/screens/disciplina_form_screen.dart
import 'package:flutter/material.dart';

import '../models/disciplina.dart';
import '../widgets/disciplina_form.dart';

class DisciplinaFormScreen extends StatelessWidget {
  final Disciplina? disciplina;

  DisciplinaFormScreen({this.disciplina});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(disciplina == null ? 'Criar Disciplina' : 'Editar Disciplina'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DisciplinaForm(
            disciplina: disciplina, onSave: () => Navigator.pop(context, true)),
      ),
    );
  }
}
