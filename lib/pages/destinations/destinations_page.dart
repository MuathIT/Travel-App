import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/models/trip_model.dart';
import 'package:travel_app/pages/trip_details/trip_details_page.dart';

class DestinationsPage extends StatelessWidget {
  final List<Trip> trips; // get the trips.
  const DestinationsPage({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          'Destinations',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        itemCount: trips.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 trips in each row.
          crossAxisSpacing: 20, // the space between each trip horziontally.
          mainAxisSpacing: 20, // the space between each trip vertically.
        ),
        padding: EdgeInsets.all(8),
        // build the trips.
        itemBuilder: (_, index) {
          // get the current index trip.
          final trip = trips[index];
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
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: trip.image,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(color: Colors.brown),
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
      ),
    );
  }
}
