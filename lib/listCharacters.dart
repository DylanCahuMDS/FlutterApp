import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydigitalgpt/characterPage.dart';
import 'package:mydigitalgpt/createCharacter.dart';
import 'package:mydigitalgpt/universPage.dart';
import 'dart:convert';

class ListCharactersPage extends StatefulWidget {
  final int universId;

  const ListCharactersPage({Key? key, required this.universId})
      : super(key: key);

  @override
  _ListCharactersPageState createState() => _ListCharactersPageState();
}

class _ListCharactersPageState extends State<ListCharactersPage> {
  List<dynamic> _characters = [
    {'name': 'Character 1', 'id': 1, 'universId': 1},
    {'name': 'Character 2', 'id': 2, 'universId': 1},
    {'name': 'Character 3', 'id': 3, 'universId': 1},
    {'name': 'Character 4', 'id': 1, 'universId': 2},
    {'name': 'Character 5', 'id': 2, 'universId': 2},
    {'name': 'Character 6', 'id': 3, 'universId': 3},
    {'name': 'Character 7', 'id': 1, 'universId': 3},
    {'name': 'Character 8', 'id': 2, 'universId': 3},
    {'name': 'Character 9', 'id': 3, 'universId': 3},
  ]; // Liste des personnages récupérés

  @override
  void initState() {
    super.initState();
    _fetchCharacters(); // Appel de la fonction pour récupérer les personnages au chargement de la page
  }

  Future<void> _fetchCharacters() async {
    final response =
        await http.get(Uri.https('caen0001.mds-caen.yt', '/characters'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _characters =
            data['characters']; // Mise à jour de la liste des personnages
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredCharacters = _characters
        .where((character) => character['universId'] == widget.universId)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des personnages'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UniversPage(
                          id: widget.universId,
                        )),
              );
            },
            child: const Text('Modifier l\'univers'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCharacterPage()),
              );
            },
            child: const Text('Créer un personnage'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final characters = filteredCharacters[index];
                return ListTile(
                  title: Text(characters['name']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterPage(
                          id: characters['id'],
                          universId: characters['universId'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
