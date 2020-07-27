class Contato {
  final String nome;
  final int conta;
  int id;

  Contato(this.nome, this.conta, {this.id});

  @override
  String toString() {
    return 'Contato: { nome: $nome, conta: $conta }';
  }
}