import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mydigitalgpt/userPage.dart';

class ListUsersPage extends StatefulWidget {
  @override
  _ListUsersPageState createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  List<dynamic> _users = [
    {'username': 'User 1', 'id': 1},
    {'username': 'User 2', 'id': 2},
    {'username': 'User 3', 'id': 3}
  ]; // Liste des utilisateurs récupérés

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Appel de la fonction pour récupérer les utilisateurs au chargement de la page
  }

  Future<void> _fetchUsers() async {
    final response =
        await http.get(Uri.https('caen0001.mds-caen.yt', '/users'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _users = data['users']; // Mise à jour de la liste des utilisateurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Utilisateurs'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user['username']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(
                    id: user['id'],
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
