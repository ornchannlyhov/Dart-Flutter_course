import 'package:flutter/material.dart';
import 'package:rentroom_management/view/widget/card/receipt_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts',style: TextStyle(color: Colors.white),),
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.add,color: Colors.white,))],
        backgroundColor: Colors.grey[850],
      ),
      body: ListView(
        children: const [
          ReceiptCard(
            roomName: 'Room 01',
            isPaid: true,
            details: {'Room Price': '70\$', 'Total': '120\$'},
            status: '',
          ),
          ReceiptCard(
            roomName: 'Room 02',
            isPaid: true,
            details: {
              'Room Price': '70\$',
              'Water Used': '20',
              'Electric Used': '20',
              'Total': '120\$'
            },
            status: '',
          ),
        ],
      ),
    );
  }
}
