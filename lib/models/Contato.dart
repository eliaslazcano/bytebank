class Contato {
  final String nome;
  final int agencia;
  final int conta;
  int id;

  Contato(this.nome, this.agencia, this.conta, {this.id});

  @override
  String toString() {
    return 'Contato: { nome: $nome, agencia: $agencia, conta: $conta }';
  }
}