import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mydigitalgpt/login.dart';

class CreateUniversPage extends StatefulWidget {
  @override
  _CreateUniversPageState createState() => _CreateUniversPageState();
}

class _CreateUniversPageState extends State<CreateUniversPage> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> _createUnivers() async {
    final String name = _nameController.text;

    if (name == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Le nom de l\'univers ne peut pas être vide'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    final String body = json.encode({
      'name': name,
    });
    print('body : $body');

    final response = await http.post(
      Uri.https('caen0001.mds-caen.yt', '/univers'),
      body: body,
    );

    print('Code de statut : ${response.statusCode}');
    print('Corps de la réponse : ${response.body}');

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Univers créé !'),
          content: const Text('Nouvel univers enregistré avec succès.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur de création'),
          content: const Text('Erreur lors de la création de l\'univers.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Création d'univers"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom de l\'univers',
              ),
            ),
            ElevatedButton(
              onPressed: _createUnivers,
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }
}
