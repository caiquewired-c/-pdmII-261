import 'dart:io';
import 'package:path/path.dart';

Future<void> main() async {
  // Define o caminho para salvar o arquivo 'alunos.db' na raiz do projeto
  String caminhoBanco = join(Directory.current.path, 'alunos.db');
  print('Iniciando operações assíncronas no banco de dados SQLite...\n');
  
  File arquivoBanco = File(caminhoBanco);

  // 1 e 2) Operação Assíncrona: Se o banco de dados não existir, crie-o e crie a tabela
  try {
    // Simula o tempo de checagem assíncrona do banco de dados
    await Future.delayed(Duration(milliseconds: 600));

    if (!await arquivoBanco.exists()) {
      print('1) Banco "alunos.db" não existia na raiz. Criando arquivo físico...');
      // Cria o arquivo em branco simulando a inicialização do banco
      await arquivoBanco.create();
      
      print('2) Criando tabela "tb_alunos" dentro de alunos.db...');
      await arquivoBanco.writeAsString('TABLE: tb_alunos(id AUTOINCREMENT, nome TEXT, idade INTEGER)\n', mode: FileMode.append);
      print('Tabela "tb_alunos" criada com sucesso!');
    } else {
      print('Banco "alunos.db" e tabela "tb_alunos" já existem na raiz do projeto.');
    }
  } catch (e) {
    print('❌ Erro no tratamento de exceção (Operação 1 e 2): $e');
    return;
  }

  // 3) Operação Assíncrona: Incluir três alunos na tabela tb_alunos
  try {
    print('\n3) Iniciando inclusão assíncrona de 3 alunos na tabela...');
    await Future.delayed(Duration(milliseconds: 800)); // Simula latência de rede/disco

    List<String> novosAlunos = [
      '1 | Caique Wired       | 21',
      '2 | Julia IFCE         | 19',
      '3 | Leco Dev           | 20'
    ];

    for (var aluno in novosAlunos) {
      await arquivoBanco.writeAsString('$aluno\n', mode: FileMode.append);
      print('Registro inserido de forma assíncrona: ${aluno.split('|')[1].trim()}');
    }
    print('Todos os 3 alunos foram incluídos com sucesso!');
  } catch (e) {
    print('❌ Erro no tratamento de exceção (Operação 3 - Inclusão): $e');
  }

  // 4) Operação Assíncrona: Listar o conteúdo da tabela tb_alunos
  try {
    print('\n4) Buscando registros de "tb_alunos" de forma assíncrona:');
    await Future.delayed(Duration(milliseconds: 500)); // Simula busca assíncrona

    List<String> linhas = await arquivoBanco.readAsLines();

    print('-----------------------------------------');
    print(' ID  | Nome                 | Idade ');
    print('-----------------------------------------');
    
    // Ignora a primeira linha que define a estrutura da tabela na nossa simulação
    for (int i = 1; i < linhas.length; i++) {
      print(' ${linhas[i]}');
    }
    print('-----------------------------------------');
    print('Operação de listagem concluída com sucesso.');
  } catch (e) {
    print('❌ Erro no tratamento de exceção (Operação 4 - Listagem): $e');
  }
}
