// lib/screens/curso_form_screen.dart
import 'package:flutter/material.dart';

import '../models/curso.dart';
import '../widgets/curso_form.dart';

class CursoFormScreen extends StatelessWidget {
  final Curso? curso;

  CursoFormScreen({this.curso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(curso == null ? 'Criar Curso' : 'Editar Curso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            CursoForm(curso: curso, onSave: () => Navigator.pop(context, true)),
      ),
    );
  }
}
