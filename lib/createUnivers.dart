import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateUniversePage extends StatefulWidget {
  @override
  _CreateUniversePageState createState() => _CreateUniversePageState();
}

class _CreateUniversePageState extends State<CreateUniversePage> {
  final TextEditingController _nameController = TextEditingController();

  Future<void> _createUniverse() async {
    final String name = _nameController.text;

    // Création du corps de la requête en utilisant le nom de l'univers
    final String body = json.encode({
      'name': name,
    });

    // Envoi de la requête POST pour créer un nouvel univers
    final response = await http.post(
      Uri.https('example.com', '/universes'),
      body: body,
    );

    if (response.statusCode == 201) {
      // Succès de la création de l'univers
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Succès'),
          content: const Text('L\'univers a été créé avec succès.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                // Naviguer vers la liste des univers
                // par exemple : Navigator.pushNamed(context, '/universes');
              },
            ),
          ],
        ),
      );
    } else {
      // Erreur lors de la création de l'univers
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Une erreur s\'est produite lors de la création de l\'univers.'),
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
        title: const Text('Création d\'univers'),
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
              onPressed: _createUniverse,
              child: const Text('Créer l\'univers'),
            ),
          ],
        ),
      ),
    );
  }
}
