import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/controllers/home/home_controller.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/core/data/shared_preference.dart';
import 'package:travel_app/core/descriptions.dart';
import 'package:travel_app/pages/destinations/destinations_page.dart';
import 'package:travel_app/pages/search/search_page.dart';
import 'package:travel_app/pages/splash/splash_page.dart';
import 'package:travel_app/pages/trip_details/trip_details_page.dart';

/* 
// app bar.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // avatar.
                CircleAvatar(
                  radius: 25,
                  backgroundImage: ExactAssetImage(
                    'assets/images/avatar1.jpeg',
                  ),
                ),
        
                // trip planner.
                Text(
                  'Trip Planner',
                  style: GoogleFonts.lato(
                    color: ColorsManager.darkBrown,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        
                // temp logout button.
                IconButton(
                  onPressed: () {
                    SharedPreferenceHelper().clear();
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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SearchPage())
                    );
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
            ),
*/

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // // app pages.
  // final _pages = [
  //   // home.
  //   HomePage(),

  //   // my trips.

  //   // favorites.

  //   // community.

  // ];

  // selected page.
  int _selectedPage = 0;

  // navigation function.
  void _navigate(int index) {
    _selectedPage = index;
  }

  // new trip.
  final Map<String, dynamic> newTrip = {
    'source': 'assets/images/new_trip.jpeg',
    'title': 'Lake Annecy , France',
    'description': Descriptions.new_trip.trim(),
    'rating': 4.9.toString(),
  };

  // trips.
  final List<Map<String, String>> trips = [
    {
      // 1st trip.
      'source': 'assets/images/trip1.jpeg',
      'title': 'Lake Como, Italy',
      'description': Descriptions.trip1.trim(),
      'rating': 4.6.toString(),
    },
    {
      // 2nd trip.
      'source': 'assets/images/trip2.jpeg',
      'title': 'Banff Park, Canada',
      'description': Descriptions.trip2.trim(),
      'rating': 4.3.toString(),
    },
    {
      // 3rd trip.
      'source': 'assets/images/trip3.jpeg',
      'title': 'Mount Gonggar, China',
      'description': Descriptions.trip3.trim(),
      'rating': 4.9.toString(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    // this method will navigate the pressed trip to the trip details page.
    void goToTripDetailsPage(Map<String, dynamic> trip) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => TripDetailsPage(trip: trip)));
    }

    return Scaffold(
      backgroundColor: ColorsManager.white,
      bottomNavigationBar: CurvedNavigationBar(
        color: ColorsManager.darkBrown,
        backgroundColor: ColorsManager.white,
        animationCurve: Curves.linearToEaseOut,
        index: _selectedPage, // display the current index page.
        onTap: _navigate, // onTap? navigate to the page.
        items: [
          // home.
          Icon(Icons.home_outlined, size: 30, color: Colors.white),

          // my trips
          Icon(Icons.map_outlined, size: 30, color: Colors.white),

          // favorites.
          Icon(Icons.favorite_border, size: 30, color: Colors.white),

          // community.
          Icon(Icons.people_outline, size: 30, color: Colors.white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    SharedPreferenceHelper().clear();
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
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),

                        GestureDetector(
                          // new trip.
                          // onTap: () {
                          //   // go to details page.
                          //   goToTripDetailsPage(newTrip);
                          // },
                          child: Container(
                            height: 350,
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: AssetImage(newTrip['source']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // new for you.
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
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
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white70,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // star.
                                          Icon(
                                            Icons.star_purple500_sharp,
                                            color: Colors.amber,
                                          ),

                                          // rating.
                                          Text(
                                            newTrip['rating'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                  newTrip['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // description.
                                Text(
                                  Descriptions.new_trip.trim(),
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
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
                                    builder: (_) =>
                                        DestinationsPage(trips: trips),
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
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: ListView.separated(
                            itemCount: state.trips.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              // current index trip.
                              final trip = state.trips[index];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                        // borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey.shade300, blurRadius: 12)
                                        ]
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl: trip['image'],
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.brown,),),
                                          errorWidget: (context, url, error) => const Center(child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40,)),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  // trip name.
                                  Text(
                                    trip['title'],
                                    style: TextStyle(
                                      color: ColorsManager.darkBrown,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // const SizedBox(height: 15),

                                  // trip description.
                                  SizedBox(
                                    width: 175,
                                    child: Text(
                                      trip['description'],
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
    );
  }
}
