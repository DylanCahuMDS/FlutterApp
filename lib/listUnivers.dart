import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydigitalgpt/listCharacters.dart';
import 'package:mydigitalgpt/universPage.dart';
import 'dart:convert';

class ListUniversPage extends StatefulWidget {
  @override
  _ListUniversPageState createState() => _ListUniversPageState();
}

class _ListUniversPageState extends State<ListUniversPage> {
  List<dynamic> _univers = [
    {'name': 'Univers 1', 'id': 1},
    {'name': 'Univers 2', 'id': 2},
    {'name': 'Univers 3', 'id': 3}
  ]; // Liste des utilisateurs récupérés

  @override
  void initState() {
    super.initState();
    _fetchUnivers(); // Appel de la fonction pour récupérer les utilisateurs au chargement de la page
  }

  Future<void> _fetchUnivers() async {
    final response =
        await http.get(Uri.https('caen0001.mds-caen.yt', '/univers'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _univers = data['univers']; // Mise à jour de la liste des utilisateurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Univers'),
      ),
      body: ListView.builder(
        itemCount: _univers.length,
        itemBuilder: (context, index) {
          final univers = _univers[index];
          return ListTile(
            title: Text(univers['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListCharactersPage(
                    universId: univers['id'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
