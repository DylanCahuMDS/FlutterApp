import 'package:flutter/material.dart';
import 'package:mydigitalgpt/createUnivers.dart';
import 'package:mydigitalgpt/listUnivers.dart';
import 'package:mydigitalgpt/login.dart';
import 'package:mydigitalgpt/listusers.dart';
import 'package:mydigitalgpt/universPage.dart';

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
      body: //bouton "liste des users"
          Center(
        child: Column(
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
                  MaterialPageRoute(builder: (context) => CreateUniversPage()),
                );
              },
              child: const Text('Créer un univers'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListUniversPage()),
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
