import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersoPage extends StatefulWidget {
  final int id;
  final int idPerso;
  final int idConv;

  const PersoPage(
      {Key? key, required this.id, required this.idPerso, required this.idConv})
      : super(key: key);

  @override
  _PersoPageState createState() => _PersoPageState();
}

class _PersoPageState extends State<PersoPage> {
  TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  String persoName = "";

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    final response = await http.get(
      Uri.https('example.com',
          '/universes/${widget.id}/characters/${widget.idPerso}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> messages = data['messages'];

      setState(() {
        _messages = messages.cast<String>().toList();
      });
    } else {
      // Gérer l'erreur de récupération des messages
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text;
    _messageController.clear();

    final body = json.encode({
      'message': message,
    });

    final response = await http.post(
      Uri.https('example.com', '/conversations/${widget.idConv}/message'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Message envoyé avec succès
      _fetchMessages();
    } else {
      //popup erreur
    }
  }

  Future<void> _NomConv() async {
    final response = await http.get(
      Uri.https('example.com',
          '/universes/${widget.id}/characters/${widget.idPerso}'),
    );

    if (response.statusCode == 200) {
      persoName = response.body;
    } else {
      persoName = "Test";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(persoName),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Afficher le menu avec les options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
