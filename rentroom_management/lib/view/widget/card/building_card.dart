import 'package:flutter/material.dart';

class BuildingCard extends StatefulWidget {
  final String buildingName;
  final Map<String, dynamic> details;

  const BuildingCard({
    required this.buildingName,
    required this.details,
    super.key,
  });

  @override
  _BuildingCardState createState() => _BuildingCardState();
}

class _BuildingCardState extends State<BuildingCard> {
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
              widget.buildingName,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            trailing: IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
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
