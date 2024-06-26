// lib/widgets/disciplina_form.dart
import 'package:flutter/material.dart';
import '../models/disciplina.dart';
import '../models/curso.dart';
import '../services/disciplina_service.dart';
import '../services/curso_service.dart';

class DisciplinaForm extends StatefulWidget {
  final Disciplina? disciplina;
  final VoidCallback onSave;

  DisciplinaForm({this.disciplina, required this.onSave});

  @override
  _DisciplinaFormState createState() => _DisciplinaFormState();
}

class _DisciplinaFormState extends State<DisciplinaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  Curso? _selectedCurso;
  final DisciplinaService _disciplinaService = DisciplinaService();
  final CursoService _cursoService = CursoService();
  late Future<List<Curso>> _cursos;

  @override
  void initState() {
    super.initState();
    _cursos = _cursoService.fetchCursos();
    if (widget.disciplina != null) {
      _nomeController.text = widget.disciplina!.nome;
      _descricaoController.text = widget.disciplina!.descricao;
    }
  }

  void _initializeSelectedCurso(List<Curso> cursos) {
    if (widget.disciplina != null && _selectedCurso == null) {
      _selectedCurso = cursos.firstWhere(
            (curso) => curso.id == widget.disciplina!.cursoId,
        orElse: () => cursos.first,
      );
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
          FutureBuilder<List<Curso>>(
            future: _cursos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Failed to load cursos');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No cursos available');
              } else {
                _initializeSelectedCurso(snapshot.data!);

                return DropdownButtonFormField<Curso>(
                  value: _selectedCurso,
                  onChanged: (Curso? newValue) {
                    setState(() {
                      _selectedCurso = newValue;
                    });
                  },
                  items: snapshot.data!.map<DropdownMenuItem<Curso>>((Curso curso) {
                    return DropdownMenuItem<Curso>(
                      value: curso,
                      child: Text(curso.nome),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Curso'),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um curso';
                    }
                    return null;
                  },
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() && _selectedCurso != null) {
                Disciplina disciplina = Disciplina(
                  id: widget.disciplina?.id ?? 0,
                  nome: _nomeController.text,
                  descricao: _descricaoController.text,
                  cursoId: _selectedCurso!.id,
                );

                print('Curso ID selecionado: ${_selectedCurso!.id}');

                try {
                  if (widget.disciplina == null) {
                    await _disciplinaService.createDisciplina(disciplina);
                  } else {
                    await _disciplinaService.updateDisciplina(disciplina.id, disciplina);
                  }

                  widget.onSave();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save disciplina: $e')),
                  );
                }
              }
            },
            child: Text(widget.disciplina == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }
}
