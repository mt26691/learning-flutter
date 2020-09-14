import 'package:flutter/material.dart';
import 'package:learn_flutter/providers/greate_places.dart';
import 'package:learn_flutter/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<GreatPlaces>(
              builder: (context, greatPlaces, child) {
                if (greatPlaces.items.length <= 0) {
                  return child;
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.items[index].image,
                        ),
                      ),
                      title: Text(greatPlaces.items[index].title),
                      subtitle: Text(greatPlaces.items[index].location.address),
                      onTap: () {
                        // TODO go to detail pages
                      },
                    );
                  },
                  itemCount: greatPlaces.items.length,
                );
              },
              child: Center(
                child: Text('Got No places now, start adding some!'),
              ),
            );
          }),
    );
  }
}
