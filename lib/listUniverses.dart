import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mydigitalgpt/universePage.dart';

class ListUniversesPage extends StatefulWidget {
  @override
  _ListUniversesPageState createState() => _ListUniversesPageState();
}

class _ListUniversesPageState extends State<ListUniversesPage> {
  List<dynamic> _universes = [
    {'id': 1, 'name': 'Univers 1'},
    {'id': 2, 'name': 'Univers 2'},
    {'id': 3, 'name': 'Univers 3'},
  ]; // Liste des univers récupérés

  @override
  void initState() {
    super.initState();
    _fetchUniverses(); // Appel de la fonction pour récupérer les univers au chargement de la page
  }

  Future<void> _fetchUniverses() async {
    final response =
        await http.get(Uri.https('caen0001.mds-caen.yt', '/universes'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _universes = data['universes']; // Mise à jour de la liste des univers
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
        itemCount: _universes.length,
        itemBuilder: (context, index) {
          final universe = _universes[index];
          return ListTile(
            title: Text(universe['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UniversePage(
                    id: universe['id'],
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
