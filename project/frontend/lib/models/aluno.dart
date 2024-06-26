// lib/models/aluno.dart
class Aluno {
  final int id;
  final String nome;
  final String cpf;
  final String email;
  final String dataNascimento;

  Aluno({required this.id, required this.nome, required this.cpf, required this.email, required this.dataNascimento});

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      email: json['email'],
      dataNascimento: json['dataNascimento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'dataNascimento': dataNascimento,
    };
  }
}
