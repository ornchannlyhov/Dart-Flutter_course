import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScoreCardApp(),
    ));

class ScoreCardApp extends StatelessWidget {
  const ScoreCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Score Cards'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [ScoreCard(label: 'OOP')],
        ),
      ),
    );
  }
}

class ScoreCard extends StatefulWidget {
  final String label;

  const ScoreCard({super.key, required this.label});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  double progress = 0.0;

  void incrementProgress() {
    setState(() {
      progress = (progress + 0.1).clamp(0.0, 1.0); // Increase by 10%, max 100%
    });
  }

  void decrementProgress() {
    setState(() {
      progress = (progress - 0.1).clamp(0.0, 1.0); // Decrease by 10%, min 0%
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My score in ${widget.label}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Expanded(
                  child: ProgressBar(progress: progress),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: decrementProgress,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: incrementProgress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
