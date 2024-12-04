import 'package:flutter/material.dart';
import 'package:rentroom_management/view/widget/card/client_card.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clients',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.grey[850],
      ),
      body: ListView(
        children: const [
          ClientCard(
            clientName: 'Client Name',
            details: {'Phone Number': '123-345-567', 'Room Number': '01'},
          ),
        ],
      ),
    );
  }
}
