import 'package:flutter/material.dart';

class ReceiptCard extends StatefulWidget {
  final String roomName;
  final String status;
  final Map<String, dynamic> details;

  const ReceiptCard({
    required this.roomName,
    required this.status,
    required this.details,
    Key? key, required bool isPaid,
  }) : super(key: key);

  @override
  _ReceiptCardState createState() => _ReceiptCardState();
}

class _ReceiptCardState extends State<ReceiptCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.roomName,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.status == "Paid"
                        ? Colors.purple
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    widget.status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.details.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style:
                              const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          entry.value.toString(),
                          style:
                              const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
