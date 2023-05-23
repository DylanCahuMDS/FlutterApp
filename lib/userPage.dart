import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  final int id;

  const UserPage({Key? key, required this.id}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _fetchUserDetails();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    final response = await http.get(
      Uri.https('example.com', '/users/${widget.id}'),
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      final username = userData['username'];
      final email = userData['email'];

      setState(() {
        _usernameController.text = username;
        _emailController.text = email;
      });
    } else {
      // Gérer l'erreur de récupération des détails de l'utilisateur
      const username = 'Test';
      const email = 'test@api.com';
    }
  }

  void _saveChanges() {
    final newUsername = _usernameController.text;
    final newEmail = _emailController.text;
    // Appliquer les modifications (envoyer une requête PUT à l'API, etc.)
    print('Nouveau nom d\'utilisateur : $newUsername');
    print('Nouvelle adresse e-mail : $newEmail');
    // Afficher une confirmation ou effectuer d'autres actions nécessaires
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom d\'utilisateur:',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Entrez le nom d\'utilisateur',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Adresse e-mail:',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Entrez l\'adresse e-mail',
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
