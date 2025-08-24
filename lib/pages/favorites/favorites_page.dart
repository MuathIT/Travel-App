import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/controllers/favorites/favorites_controller.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/pages/trip_details/trip_details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // provide the cubit to the page.
    return BlocProvider(
      create: (_) => FavoritesCubit()..getFavTrips(),
      child: const FavoritesScreen(),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading){
            return const Center(
              child: CircularProgressIndicator(color: Colors.brown),
            );
          }
          else if (state is FavoritesEmpty){
            return Center(
              child: Text(
                state.emptyMessage,
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            );
          }
          else if (state is FavoritesSuccess) {
            // get the fav list from the state.
            final favoriteTrips = state.favoriteTrips;
            return GridView.builder(
              itemCount: favoriteTrips.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 trips in each row.
                crossAxisSpacing:
                    20, // the space between each trip horziontally.
                mainAxisSpacing: 20, // the space between each trip vertically.
              ),
              padding: EdgeInsets.all(8),
              // build the trips.
              itemBuilder: (_, index) {
                // get the current index trip.
                final trip = favoriteTrips[index];
                return Column(
                  children: [
                    // trip pic.
                    GestureDetector(
                      onTap: () {
                        // navigate to trip details.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TripDetailsPage(trip: trip),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 6),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: trip.image,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.brown,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // trip name.
                    Text(
                      trip.title,
                      style: TextStyle(
                        color: ColorsManager.darkBrown,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            );
          }
          else if (state is FavoritesFailure){
            return Center(
              child: Text(
                state.failureMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }
          return const SizedBox(child: Center(child: Text('Hi', style: TextStyle(color: Colors.brown),),),);
        },
      ),
    );
  }
}
