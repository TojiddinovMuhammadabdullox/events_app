import 'package:events_app/providers/favorites_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:events_app/models/event.dart';

class FavoritPage extends StatelessWidget {
  const FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        centerTitle: true,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          List<Event> favorites = favoritesProvider.favorites;

          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              Event event = favorites[index];
              return ListTile(
                title: Text(event.name),
                subtitle: Text("${event.time} ${event.date}"),
                trailing: IconButton(
                  icon: Icon(
                    CupertinoIcons.heart_circle_fill,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    favoritesProvider.toggleFavorite(event);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
