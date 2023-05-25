import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UniversPage extends StatefulWidget {
  final int id;

  const UniversPage({Key? key, required this.id}) : super(key: key);

  @override
  _UniversPageState createState() => _UniversPageState();
}

class _UniversPageState extends State<UniversPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _fetchUniversDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchUniversDetails() async {
    final response = await http.get(
      Uri.https('example.com', '/univers/${widget.id}'),
    );

    if (response.statusCode == 200) {
      final universData = json.decode(response.body);
      final name = universData['name'];

      setState(() {
        _nameController.text = name;
      });
    } else {
      // Gérer l'erreur de récupération des détails de l'univers
      const name = 'Pokémon';
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
      Uri.https('caen0001.mds-caen.yt', '/univers/${widget.id}'),
      body: body,
    );
    print('Nouvel univers : $newName');
    // Afficher une confirmation ou effectuer d'autres actions nécessaires
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Univers'),
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
