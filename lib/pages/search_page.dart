import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/controllers/auth/search/search_controllers.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/pages/trip_details_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  // search controller.
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorsManager.white,
            elevation: 0,
            pinned: true,
            toolbarHeight: 80,
            leading: IconButton(
              // back to home page button.
              onPressed: () {
                // pop the details page.
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.brown),
              hoverColor: Colors.transparent,
            ),

            // search text field.
            title: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                onSubmitted: (destination) {
                  // submit the searched destination to the API.
                  context.read<SearchCubit>().getTrip(destination.trim());
                },
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.brown[200]),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.brown[300]),
                ),
                cursorColor: Colors.brown[400],
                style: TextStyle(color: ColorsManager.darkBrown),
              ),
            ),

            // delete previous searches button.
            actions: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey.shade300,
                  ),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outlined, color: Colors.brown[300]),
                ),
              ),
            ],
            actionsPadding: EdgeInsets.all(16),
          ),

          BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {
              // display the failure message.
              if (state is SearchFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.failureMessage),
                    duration: Duration(milliseconds: 900),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SearchLoading) {
                // show dialog when loading.
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is SearchSuccess) {
                // get the trip details.
                final trip = state.trip;
                // body.
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 6),
                              ],
                            ),
                            child: CachedNetworkImage(
                              imageUrl: trip['originalimage']['source'],
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget:(context, url, error) => const Center(child: Icon(
                                Icons.broken_image_outlined,
                              )),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        // trip name.
                        Text(
                          trip['title'],
                          style: TextStyle(
                            color: ColorsManager.darkBrown,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: const Center(child: Text('Search for a trip')),
              );
            },
          ),
        ],
      ),
    );
  }
}
