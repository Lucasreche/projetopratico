import 'package:flutter/material.dart';

class RF002 extends StatefulWidget {
  const RF002({super.key});
  @override
  State<RF002> createState() => _RF002State();
}
class _RF002State extends State<RF002> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                      'lib/imagens/logo01.jpg',
                      width: 300,
                      height: 150,
                    ),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome completo.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu CPF.';
                  } else if (value.length != 11) {
                    return 'O CPF deve ter 11 dígitos.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email.';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Por favor, insira um email válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu telefone.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha.';
                  } else if (value.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'A senha deve ter 6 números.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmaSenhaController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'Confirme a Senha',
                ),
                validator: (value) {
                  if (value != _senhaController.text) {
                    return 'A senha confirmada não coincide.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Implemente a lógica de cadastro aqui
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Cadastro Efetuado!\nRetorne e faça seu login.',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1.5), // Aumenta o espaçamento entre as linhas, se necessário
                        ),
                        behavior: SnackBarBehavior.floating, // Faz o SnackBar flutuar acima dos outros widgets
                      ),
                    );
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }
}
