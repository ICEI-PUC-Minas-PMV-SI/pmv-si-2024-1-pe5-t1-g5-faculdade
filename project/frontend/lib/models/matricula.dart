import 'aluno.dart';
import 'disciplina.dart';

class Matricula {
  int id;
  Aluno aluno;
  Disciplina disciplina;
  String dataMatricula;

  Matricula({
    required this.id,
    required this.aluno,
    required this.disciplina,
    required this.dataMatricula,
  });

  factory Matricula.fromJson(Map<String, dynamic> json) {
    return Matricula(
      id: json['id'],
      aluno: Aluno.fromJson(json['aluno']),
      disciplina: Disciplina.fromJson(json['disciplina']),
      dataMatricula: json['dataMatricula'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aluno': aluno.toJson(),
      'disciplina': disciplina.toJson(),
      'dataMatricula': dataMatricula,
    };
  }
}
