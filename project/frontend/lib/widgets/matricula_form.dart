import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importar o pacote intl
import '../models/matricula.dart';
import '../models/aluno.dart';
import '../models/disciplina.dart';
import '../services/matricula_service.dart';
import '../services/aluno_service.dart';
import '../services/disciplina_service.dart';

class MatriculaForm extends StatefulWidget {
  final Matricula? matricula;
  final VoidCallback onSave;

  MatriculaForm({this.matricula, required this.onSave});

  @override
  _MatriculaFormState createState() => _MatriculaFormState();
}

class _MatriculaFormState extends State<MatriculaForm> {
  final _formKey = GlobalKey<FormState>();
  Aluno? _selectedAluno;
  Disciplina? _selectedDisciplina;
  final MatriculaService _matriculaService = MatriculaService();
  final AlunoService _alunoService = AlunoService();
  final DisciplinaService _disciplinaService = DisciplinaService();
  late Future<List<Aluno>> _alunos;
  late Future<List<Disciplina>> _disciplinas;

  @override
  void initState() {
    super.initState();
    _alunos = _alunoService.fetchAlunos();
    _disciplinas = _disciplinaService.fetchDisciplinas();
    if (widget.matricula != null) {
      // Carregar aluno e disciplina selecionados
    }
  }

  void _initializeSelectedAluno(List<Aluno> alunos) {
    if (widget.matricula != null && _selectedAluno == null) {
      _selectedAluno = alunos.firstWhere(
            (aluno) => aluno.id == widget.matricula!.aluno.id,
        orElse: () => alunos.first,
      );
    }
  }

  void _initializeSelectedDisciplina(List<Disciplina> disciplinas) {
    if (widget.matricula != null && _selectedDisciplina == null) {
      _selectedDisciplina = disciplinas.firstWhere(
            (disciplina) => disciplina.id == widget.matricula!.disciplina.id,
        orElse: () => disciplinas.first,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FutureBuilder<List<Aluno>>(
            future: _alunos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Failed to load alunos');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No alunos available');
              } else {
                _initializeSelectedAluno(snapshot.data!);

                return DropdownButtonFormField<Aluno>(
                  value: _selectedAluno,
                  onChanged: (Aluno? newValue) {
                    setState(() {
                      _selectedAluno = newValue;
                    });
                  },
                  items: snapshot.data!.map<DropdownMenuItem<Aluno>>((Aluno aluno) {
                    return DropdownMenuItem<Aluno>(
                      value: aluno,
                      child: Text(aluno.nome),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Aluno'),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um aluno';
                    }
                    return null;
                  },
                );
              }
            },
          ),
          FutureBuilder<List<Disciplina>>(
            future: _disciplinas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Failed to load disciplinas');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No disciplinas available');
              } else {
                _initializeSelectedDisciplina(snapshot.data!);

                return DropdownButtonFormField<Disciplina>(
                  value: _selectedDisciplina,
                  onChanged: (Disciplina? newValue) {
                    setState(() {
                      _selectedDisciplina = newValue;
                    });
                  },
                  items: snapshot.data!.map<DropdownMenuItem<Disciplina>>((Disciplina disciplina) {
                    return DropdownMenuItem<Disciplina>(
                      value: disciplina,
                      child: Text(disciplina.nome),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Disciplina'),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione uma disciplina';
                    }
                    return null;
                  },
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() && _selectedAluno != null && _selectedDisciplina != null) {
                String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now()); // Formatar a data

                Matricula matricula = Matricula(
                  id: widget.matricula?.id ?? 0,
                  aluno: _selectedAluno!,
                  disciplina: _selectedDisciplina!,
                  dataMatricula: currentDate, // Definir a data formatada
                );

                print('Aluno ID selecionado: ${_selectedAluno!.id}');
                print('Disciplina ID selecionada: ${_selectedDisciplina!.id}');
                print('Data de matrícula: $currentDate');

                try {
                  if (widget.matricula == null) {
                    await _matriculaService.createMatricula(matricula);
                  } else {
                    await _matriculaService.updateMatricula(matricula.id, matricula);
                  }

                  widget.onSave();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save matricula: $e')),
                  );
                }
              }
            },
            child: Text(widget.matricula == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }
}
