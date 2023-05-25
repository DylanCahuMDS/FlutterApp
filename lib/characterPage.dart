import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterPage extends StatefulWidget {
  final int id;
  final int universId;

  const CharacterPage({Key? key, required this.id, required this.universId})
      : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _fetchCharactersDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchCharactersDetails() async {
    final response = await http.get(
      Uri.https('example.com', '/univers/characters/${widget.id}'),
    );

    if (response.statusCode == 200) {
      final charactersData = json.decode(response.body);
      final name = charactersData['name'];

      setState(() {
        _nameController.text = name;
      });
    } else {
      // Gérer l'erreur de récupération des détails de l'univers
      const name = 'Pierre';
      setState(() {
        _nameController.text = name;
      });
    }
  }

  Future<void> _saveChanges() async {
    final newName = _nameController.text;

    final String body = json.encode({
      'name': newName,
    });

    //put request with newName
    final response = await http.put(
      Uri.https('caen0001.mds-caen.yt',
          '/univers/${widget.universId}/characters/${widget.id}'),
      body: body,
    );
    print('Nouveau personnage : $newName');
    // Afficher une confirmation ou effectuer d'autres actions nécessaires
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom du personnage:',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Entrez le nom du personnage',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
