import 'package:flutter/material.dart';
import 'package:testapp1/W6-S2-list/EXERCISE-4/joke.dart';


void main() => runApp(const MaterialApp(
      home: JokeList(),
    ));

class JokeList extends StatefulWidget {
  const JokeList({super.key});

  @override
  State<JokeList> createState() => _JokeListState();
}

class _JokeListState extends State<JokeList> {
  int? _bestJokeIndex;

  void onFavoriteClick(int index) {
    setState(() {
      if (_bestJokeIndex == index) {
        _bestJokeIndex = null;
      } else {
        _bestJokeIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Favorite Jokes"),
      ),
      body: ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          return FavoriteCard(
            title: jokes[index]['title']!,
            description: jokes[index]['description']!,
            isFavorite: _bestJokeIndex == index,
            onFavoriteClick: () => onFavoriteClick(index),
          );
        },
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isFavorite;
  final VoidCallback onFavoriteClick;

  const FavoriteCard({
    super.key,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(color: Colors.green, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(description),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoriteClick,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
