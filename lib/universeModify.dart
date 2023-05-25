import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UniverseModify extends StatefulWidget {
  final int id;

  const UniverseModify({Key? key, required this.id}) : super(key: key);

  @override
  _UniverseModifyState createState() => _UniverseModifyState();
}

class _UniverseModifyState extends State<UniverseModify> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _fetchUniverseDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchUniverseDetails() async {
    final response = await http.get(
      Uri.https('caen0001.mds-caen.yt', '/universes/${widget.id}'),
    );

    if (response.statusCode == 200) {
      final universeData = json.decode(response.body);
      final name = universeData['name'];

      setState(() {
        _nameController.text = name;
      });
    } else {
      // Gérer l'erreur de récupération des détails de l'univers
      const name = 'Univers Test';
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

    // Requête PUT avec le nouveau nom de l'univers
    final response = await http.put(
      Uri.https('caen0001.mds-caen.yt', '/universes/${widget.id}'),
      body: body,
    );
    print('Nouveau nom de l\'univers : $newName');
    // Afficher une confirmation ou effectuer d'autres actions nécessaires
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'univers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom de l\'univers:',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Entrez le nom de l\'univers',
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
