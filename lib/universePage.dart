import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mydigitalgpt/persoPage.dart';

class UniversePage extends StatefulWidget {
  final int id;

  const UniversePage({Key? key, required this.id}) : super(key: key);

  @override
  _UniversePageState createState() => _UniversePageState();
}

class _UniversePageState extends State<UniversePage> {
  List<dynamic> _characters = [];

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    final response = await http.get(
      Uri.https('caen0001.mds-caen.yt', '/universes/${widget.id}/characters'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _characters = data['characters'];
      });
    } else {
      _characters = [
        {
          'id': 1,
          'name': 'Personnage 1',
        },
        {
          'id': 2,
          'name': 'Personnage 2',
        },
        {
          'id': 3,
          'name': 'Personnage 3',
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personnages de l\'univers'),
      ),
      body: ListView.builder(
        itemCount: _characters.length,
        itemBuilder: (context, index) {
          final character = _characters[index];
          return ListTile(
            title: Text(character['name']),
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersoPage(
                    id: character['id'],
                  ),
                ),
              );*/
            },
          );
        },
      ),
    );
  }
}
