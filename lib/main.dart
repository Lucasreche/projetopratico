// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:projetopratico/view/home_screen.dart';
import 'package:projetopratico/view/rf002.dart';
import 'package:projetopratico/view/rf003.dart';
import 'package:projetopratico/view/rf004.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyList',
      home: PrincipalView(),
    );
  }
}

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  //
  // Atributos
  //

  //Identificador do formulário
  var formKey = GlobalKey<FormState>();

  //Controladores dos campos de texto
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max, // Assegura que a Column ocupe o máximo de espaço
                  children: [
                    Image.asset(
                      'lib/imagens/logo01.jpg',
                      width: 400,
                      height: 200,
                    ),
                ////
                //// Adicionar o Texto "Login"
                ////
                Text(
                  'Login',
                  style: TextStyle(
                    // Estilos do texto "Login"
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 140, 0), 
                    fontFamily: 'BerlinSansFB',
                  ),
                ),
                //
                // CAMPO DE TEXTO
                //
                TextFormField(
                  controller: txtValor1,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Digite seu email',
                    border: OutlineInputBorder(),
                  ),
                  //
                  // Validação
                  //
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                    return 'Informe um e-mail válido';
                    } else {
                      // Expressão regular para validação de e-mail
                      const pattern = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';
                      final regExp = RegExp(pattern);

                      if (!regExp.hasMatch(value)) {
                        return 'Informe um e-mail válido';
                      }
                    }
                    // Retornar null significa que o campo foi validado com sucesso!
                    return null;
                  },
                ),

                SizedBox(height: 25),
                TextFormField(
                  controller: txtValor2,
                  obscureText: true, 
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Digite sua senha',
                    border: OutlineInputBorder(),
                  ),
                  //
                  // Validação
                  //
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe uma senha';
                    } else if (value.length != 6) {
                      return 'A senha deve ter 6 números';
                    } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                      return 'Use apenas números na senha';
                    }
                    // Retornar null significa que o campo foi validado com sucesso!
                    return null;
                  },
                ),

                SizedBox(height: 25),
                SizedBox(height: 20), // Espaço vertical entre os botões
                
                //
                // BOTÃO
                //
                //ElevatedButton, OutlinedButton, TextButton
                ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 255, 140, 0),
    foregroundColor: Color.fromARGB(255, 255, 255, 255),
    minimumSize: Size(150,40),
  ),
  onPressed: () {
    // Validação dos campos
    if (formKey.currentState!.validate()) {
      // Aqui você pode incluir a lógica de verificação do email e senha

      // Se a verificação for bem-sucedida, navegue para a HomeScreen
      Navigator.pushReplacement( // Esta linha foi alterada para usar pushReplacement
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  },
  child: Text(
    'Entrar',
    style: TextStyle(fontSize: 24, fontFamily: 'BerlinSansFB'),
  ),
),


                SizedBox(height: 40), // Espaço vertical entre os botões
                

                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 17, 69, 190), // Cor do texto
                    textStyle: TextStyle(fontSize: 16),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RF002()),
                    );
                  },
                  child: Text('Cadastre-se'),
                ),

                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 17, 69, 190),
                    textStyle: TextStyle(fontSize: 16),
                    minimumSize: Size(150, 40),
                  ),
                  onPressed: () {
                    // Navegação para a tela RF003
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RF003()), // Substitua RF003 pelo widget correto se necessário
                    );
                  },
                  child: Text('Esqueci minha senha'),
                ),

              Expanded(child: Container()), // Isso empurra tudo para cima
            ],
          ),
        ),
      ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
              child: Container(
                height: 50, // Altura total do container, metade ficará "submersa"
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 212, 171),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // Navegar para a tela RF004
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RF004()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 128, 0), // Cor do texto do botão
                      textStyle: TextStyle(fontSize: 16, fontFamily: 'BerlinSansFB'), 
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espaçamento interno do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Bordas arredondadas do botão
                      ),
                    ),
                    child: Text("Sobre o App EasyList"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}