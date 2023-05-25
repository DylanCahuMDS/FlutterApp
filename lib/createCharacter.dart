import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mydigitalgpt/login.dart';

class CreateCharacterPage extends StatefulWidget {
  @override
  _CreateCharacterPageState createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> _createCharacter() async {
    final String name = _nameController.text;

    if (name == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Le nom du personnage ne peut pas être vide'),
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
      Uri.https('caen0001.mds-caen.yt', '/character'),
      body: body,
    );

    print('Code de statut : ${response.statusCode}');
    print('Corps de la réponse : ${response.body}');

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Personnage créé !'),
          content: const Text('Nouveau personnage enregistré avec succès.'),
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
          content: const Text('Erreur lors de la création du personnage.'),
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
        title: const Text("Créer un personnage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom du personnage',
              ),
            ),
            ElevatedButton(
              onPressed: _createCharacter,
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }
}
