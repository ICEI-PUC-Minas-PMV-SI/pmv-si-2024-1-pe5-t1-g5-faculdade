// lib/models/curso.dart
class Curso {
  final int id;
  final String nome;
  final String descricao;

  Curso({required this.id, required this.nome, required this.descricao});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
    };
  }
}
