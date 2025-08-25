import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:travel_app/controllers/favorite/favorite_controller.dart';
import 'package:travel_app/models/trip_model.dart';

class TripDetailsPage extends StatelessWidget {
  final Trip trip;
  const TripDetailsPage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.failureMessage),
                duration: Duration(milliseconds: 900),
              ),
            );
          } else if (state is FavoriteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Favorites updated'),
                duration: Duration(milliseconds: 900),
              ),
            );
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: Colors.grey[200],
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            shape: const CircleBorder(),
            onPressed: null, // disable default tap, we’ll use LikeButton
            child: LikeButton(
              isLiked: trip.isFavorited,
              onTap: (liked) async {
                if (liked) {
                  // already liked → remove from favorites
                  context.read<FavoriteCubit>().removeFromFavorite(
                    trip.title,
                  );
                } else {
                  // not liked → add to favorites
                  context.read<FavoriteCubit>().addToFavorite(trip);
                }
                return !liked; // toggle button state
              },
              likeBuilder: (bool liked) {
                return Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  color: liked ? Colors.red : Colors.grey,
                  size: 30,
                );
              },
            ),
          );
          // return const SizedBox.shrink();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          // back to home page button.
          onPressed: () {
            // pop the details page.
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.brown),
          hoverColor: Colors.transparent,
        ),
        centerTitle: true,
        title: Text(
          // trip name.
          trip.title,
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),

        // rating.
        actions: [
          // star.
          Icon(
            Icons.star_purple500_sharp,
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 5),

          // rating.
          Text(
            trip.rating,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
        ],
        actionsPadding: EdgeInsets.all(16),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // trip image.
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 8)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  // this widget let you handle the image loading & error.
                  imageUrl: trip.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.brown),
                  ), // show loading indicator when loading the image.
                  errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image_outlined,
                    size: 80,
                    color: Colors.grey,
                  ), // handles the error.
                ),
              ),
            ),

            const SizedBox(height: 20),

            // trip description.
            Text(
              trip.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
