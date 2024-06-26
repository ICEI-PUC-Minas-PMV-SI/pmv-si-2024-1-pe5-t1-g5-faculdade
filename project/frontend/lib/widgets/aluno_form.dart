// lib/widgets/aluno_form.dart
import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../services/aluno_service.dart';

class AlunoForm extends StatefulWidget {
  final Aluno? aluno;
  final VoidCallback onSave;

  AlunoForm({this.aluno, required this.onSave});

  @override
  _AlunoFormState createState() => _AlunoFormState();
}

class _AlunoFormState extends State<AlunoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final AlunoService _alunoService = AlunoService();

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      _nomeController.text = widget.aluno!.nome;
      _cpfController.text = widget.aluno!.cpf;
      _emailController.text = widget.aluno!.email;
      _dataNascimentoController.text = widget.aluno!.dataNascimento;
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
            controller: _cpfController,
            decoration: InputDecoration(labelText: 'CPF'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o CPF';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _dataNascimentoController,
            decoration: InputDecoration(labelText: 'Data de Nascimento'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira a data de nascimento';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Aluno aluno = Aluno(
                  id: widget.aluno?.id ?? 0,
                  nome: _nomeController.text,
                  cpf: _cpfController.text,
                  email: _emailController.text,
                  dataNascimento: _dataNascimentoController.text,
                );

                if (widget.aluno == null) {
                  await _alunoService.createAluno(aluno);
                } else {
                  await _alunoService.updateAluno(aluno.id, aluno);
                }

                widget.onSave();
              }
            },
            child: Text(widget.aluno == null ? 'Criar' : 'Atualizar'),
          ),
        ],
      ),
    );
  }
}
