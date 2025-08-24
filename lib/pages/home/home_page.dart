import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controllers/favorites/favorites_controller.dart';
import 'package:travel_app/controllers/home/home_controller.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/core/data/shared_preference.dart';
import 'package:travel_app/models/trip_model.dart';
import 'package:travel_app/pages/destinations/destinations_page.dart';
import 'package:travel_app/pages/search/search_page.dart';
import 'package:travel_app/pages/splash/splash_page.dart';
import 'package:travel_app/pages/trip_details/trip_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // this method will navigate the pressed trip to the trip details page.
    void goToTripDetailsPage(Trip trip) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => TripDetailsPage(trip: trip)));
    }

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ColorsManager.white,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/avatar1.jpeg'),
                ),
                centerTitle: true,
                title: Text(
                  'Trip Planner',
                  style: GoogleFonts.lato(
                    color: ColorsManager.darkBrown,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  // temp logout button.
                  IconButton(
                    onPressed: () {
                      // clear the shared preference.
                      SharedPreferenceHelper().clear();
                      // close the stream supscription.
                      context.read<FavoritesCubit>().close(); 
                      // navigate to the splash page.
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const SplashPage()),
                        (_) => false,
                      );
                    },
                    icon: const Icon(Icons.logout),
                  ),
        
                  // serach button.
                  GestureDetector(
                    onTap: () {
                      // navigate to the search page.
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => SearchPage()));
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Image.asset('assets/icons/search_icon.png'),
                    ),
                  ),
                ],
                actionsPadding: EdgeInsets.all(8),
              ),
        
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.brown),
                      ),
                    );
                  } else if (state is HomeFailure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          state.failureMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    // get the random trip to use it in (new for you trip).
                    final randomTrip = state.randomTrip;
                    // home UI.
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
        
                          // new for you trip.
                          GestureDetector(
                            onTap: () {
                              // go to details page.
                              goToTripDetailsPage(randomTrip);
                            },
                            child: Container(
                              height: 350,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 12),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(25),
                                child: Stack(
                                  children: [
                                    // random trip image.
                                    CachedNetworkImage(
                                      imageUrl: randomTrip.image,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.brown,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                            child: Icon(
                                              Icons.broken_image_outlined,
                                              color: Colors.grey,
                                              size: 40,
                                            ),
                                          ),
                                      fit: BoxFit.cover,
                                      height: 350,
                                      width: double.infinity,
                                    ),
        
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // new for you.
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: ColorsManager.darkBrown,
                                                ),
                                                child: Text(
                                                  'New for you',
                                                  style: GoogleFonts.robotoFlex(
                                                    color: ColorsManager.white,
                                                  ),
                                                ),
                                              ),
        
                                              // rating.
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.white70,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    // star.
                                                    Icon(
                                                      Icons.star_purple500_sharp,
                                                      color: Colors.amber,
                                                    ),
        
                                                    // rating.
                                                    Text(
                                                      randomTrip.rating,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
        
                                          const Spacer(),
        
                                          // trip name.
                                          Text(
                                            randomTrip.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
        
                                          // description.
                                          Text(
                                            randomTrip.description,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: ColorsManager.white,
                                              fontSize: 18,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
        
                          const SizedBox(height: 20),
        
                          // popular destinations.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular destinations',
                                style: TextStyle(
                                  color: ColorsManager.darkBrown,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
        
                              // view all button.
                              TextButton(
                                onPressed: () {
                                  // navigate to destinations page.
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => DestinationsPage(
                                        trips: state.popularTrips,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'View all',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
        
                                    const SizedBox(width: 5),
        
                                    // arrow.
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey.shade600,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
        
                          const SizedBox(height: 20),
        
                          // popular trips.
                          Container(
                            height: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              itemCount: state.popularTrips.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // current index trip.
                                final trip = state.popularTrips[index];
        
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    // trip image.
                                    GestureDetector(
                                      onTap: () {
                                        // go to details page.
                                        goToTripDetailsPage(trip);
                                      },
                                      child: Container(
                                        height: 175,
                                        width: 175,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Stack(
                                            children: [
                                              // current trip image.
                                              CachedNetworkImage(
                                                imageUrl: trip.image,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                            color: Colors.brown,
                                                          ),
                                                    ),
                                                errorWidget:
                                                    (
                                                      context,
                                                      url,
                                                      error,
                                                    ) => const Center(
                                                      child: Icon(
                                                        Icons
                                                            .broken_image_outlined,
                                                        color: Colors.grey,
                                                        size: 40,
                                                      ),
                                                    ),
                                                fit: BoxFit.cover,
                                                height: 175,
                                                width: 175,
                                              ),
        
                                              // current trip rating.
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              25,
                                                            ),
                                                        color: Colors.white70,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          // star.
                                                          Icon(
                                                            Icons
                                                                .star_purple500_sharp,
                                                            color: Colors.amber,
                                                          ),
        
                                                          // rating.
                                                          Text(
                                                            trip.rating,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
        
                                    // trip description.
                                    SizedBox(
                                      width: 175,
                                      child: Text(
                                        trip.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.brown[300],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
