import 'dart:convert'; // Biblioteca necessária para usar o jsonEncode

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  // Método para converter o Dependente em formato de mapa (chave: valor)
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  // Método para converter o Funcionario e sua lista de dependentes
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  // Método para converter a Equipe do Projeto inteira
  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
    };
  }
}

void main() {
  // 1. Criar varios objetos Dependentes
  Dependente dep1 = Dependente("Arthur");
  Dependente dep2 = Dependente("Beatriz");
  Dependente dep3 = Dependente("Carlos");

  // 2. Criar varios objetos Funcionario e
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  Funcionario func1 = Funcionario("João Silva", [dep1, dep2]);
  Funcionario func2 = Funcionario("Maria Souza", [dep3]);
  Funcionario func3 = Funcionario("Pedro Alves", []); // Funcionário sem dependentes

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> listaFuncionarios = [func1, func2, func3];

  // 5. Criar um objeto Equipe Projeto chamando o metodo construtor
  EquipeProjeto equipe = EquipeProjeto("Sistema Escolar", listaFuncionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto
  // O JsonEncoder.withIndent('  ') serve para deixar o texto do JSON quebrado e bonito no terminal
  var encoder = JsonEncoder.withIndent('  ');
  String jsonTexto = encoder.convert(equipe.toJson());
  
  print(jsonTexto);
}
