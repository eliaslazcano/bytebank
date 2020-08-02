class Contato {
  //Propriedades
  final String nome;
  final int agencia;
  final int conta;
  int id;

  //Construtor
  Contato(this.nome, this.agencia, this.conta, {this.id});

  //Construtor alternativo
  Contato.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    nome = json['name'],
    conta = json['accountNumber'],
    agencia = 0;

  //Função local
  Map<String, dynamic> toJson() => {
    'name': nome,
    'agencia': agencia,
    'accountNumber': conta,
    'id': id
  };

  @override
  String toString() {
    return 'Contato: { nome: $nome, agencia: $agencia, conta: $conta }';
  }
}