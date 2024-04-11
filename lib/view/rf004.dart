import 'package:flutter/material.dart';

class RF004 extends StatefulWidget {
  const RF004({super.key});
  @override
  State<RF004> createState() => _RF004State();
}
class _RF004State extends State<RF004> {
  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
      ),
      body: SingleChildScrollView( // Adiciona suporte a rolagem
        padding: const EdgeInsets.all(20.0), // Espaçamento interno para todo o corpo
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto sobre o app
            const Text(
              'Desenvolvido pelo aluno Lucas Juliano Reche, como atividade prática da matéria de Programação Para Dispositivos Moveis,'
              ' ministrado pelo Prof. Rodrigo de Oliveira Plotze.\n\n'
              'EasyList é um aplicativo para facilitar sua organização diária. '
              'O aplicativo é projetado para ajudar os usuários a criar e gerenciar listas de compras de forma eficiente. '
              'Ele permite que os usuários adicionem itens à lista, marquem itens como comprados e removam itens conforme necessário.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, fontFamily: 'BerlinSansFB'),
            ),
            // Espaço opcional entre o texto e a imagem, pode ser ajustado conforme necessário
            const SizedBox(height: 120),
            // Imagem
            Image.asset(
              'lib/imagens/logo01.jpg',
              width: 400,
              height: 200,
            ),
            // Versão do app
            const Text(
              'Versão: 1.0.0',
              textAlign: TextAlign.center,
            ),
            // Espaçamento no final
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
