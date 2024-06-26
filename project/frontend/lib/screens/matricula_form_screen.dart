// lib/screens/matricula_form_screen.dart
import 'package:flutter/material.dart';

import '../models/matricula.dart';
import '../widgets/matricula_form.dart';

class MatriculaFormScreen extends StatelessWidget {
  final Matricula? matricula;

  MatriculaFormScreen({this.matricula});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(matricula == null ? 'Criar Matrícula' : 'Editar Matrícula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MatriculaForm(
            matricula: matricula, onSave: () => Navigator.pop(context, true)),
      ),
    );
  }
}
