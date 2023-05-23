import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final String username;

  const UserPage({Key? key, required this.username}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final newUsername = _usernameController.text;
    // Appliquer les modifications (enregistrer dans la base de données, etc.)
    print('Nouveau nom d\'utilisateur : $newUsername');
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
