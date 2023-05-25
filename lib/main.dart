import 'package:flutter/material.dart';
import 'package:mydigitalgpt/login.dart';
import 'package:mydigitalgpt/createunivers.dart';
import 'package:mydigitalgpt/listusers.dart';
import 'package:mydigitalgpt/listuniverses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyDigitalGPT',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Couleur principale de l'application
      ),
      home: MyHomePage(
          title: 'Home Page'), // Page de connexion comme page d'accueil
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyDigitalGPT'),
        leading: IconButton(
          icon: Icon(Icons.login),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListUsersPage()),
                );
              },
              child: const Text('Liste des utilisateurs'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateUniversePage()),
                );
              },
              child: const Text('Créer un univers'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListUniversesPage()),
                );
              },
              child: const Text('Liste des univers'),
            ),
          ],
        ),
      ),
    );
  }
}
