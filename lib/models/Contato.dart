class Contato {
  final String nome;
  final int conta;

  Contato(this.nome, this.conta);

  @override
  String toString() {
    return 'Contato: { nome: $nome, conta: $conta }';
  }
}