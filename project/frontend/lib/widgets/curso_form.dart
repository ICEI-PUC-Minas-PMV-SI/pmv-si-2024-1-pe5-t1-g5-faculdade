// lib/widgets/curso_form.dart
import 'package:flutter/material.dart';

import '../models/curso.dart';
import '../services/curso_service.dart';

class CursoForm extends StatefulWidget {
  final Curso? curso;
  final VoidCallback onSave;

  CursoForm({this.curso, required this.onSave});

  @override
  _CursoFormState createState() => _CursoFormState();
}

class _CursoFormState extends State<CursoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final CursoService _cursoService = CursoService();

  @override
  void initState() {
    super.initState();
    if (widget.curso != null) {
      _nomeController.text = widget.curso!.nome;
      _descricaoController.text = widget.curso!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira a descrição';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Curso curso = Curso(
                  id: widget.curso?.id ?? 0,
                  nome: _nomeController.text,
                  descricao: _descricaoController.text,
                );

                if (widget.curso == null) {
                  await _cursoService.createCurso(curso);
                } else {
                  await _cursoService.updateCurso(curso.id, curso);
                }

                widget.onSave();
              }
            },
            child: Text(widget.curso == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }
}
