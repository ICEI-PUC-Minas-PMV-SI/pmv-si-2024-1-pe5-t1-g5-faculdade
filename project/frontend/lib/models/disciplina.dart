// lib/models/disciplina.dart
class Disciplina {
  final int id;
  final String nome;
  final String descricao;
  final int cursoId;

  Disciplina({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.cursoId,
  });

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      descricao: json['descricao'] ?? '',
      cursoId: json['cursoId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'cursoId': cursoId,
    };
  }
}
