
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/controllers/search/search_controllers.dart';
import 'package:travel_app/core/colors.dart';
import 'package:travel_app/pages/trip_details/trip_details_page.dart';

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
                onChanged: (value) {
                  // change the value to the API.
                  context.read<SearchCubit>().getSuggestions(value.trim());
                },
                onSubmitted: (value) => context.read<SearchCubit>().getTrip(value),
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
              if (state is SearchSuccess){
                // push the trip details page and display the searched trip. (always use listner for navigate not the builder.)
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => TripDetailsPage(trip: state.trip)));
              }
              // display the failure message.
              else if (state is SearchFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.failureMessage),
                    duration: Duration(milliseconds: 1200),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SearchLoading) {
                // show dialog when loading.
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Center(child: CircularProgressIndicator(color: Colors.brown)),
                  ),
                );
              } else if (state is SearchEmpty){
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.emptyMessage,
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18
                      ),
                    ),
                  ),
                );
              }
              else if (state is SearchSuggestions) {
                // build the trips.
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.suggestions.length,
                    (context, index) {
                      // get the current suggetion from the fetched trips.
                      final suggestion = state.suggestions[index];
                      
                      // display the current suggested trip.
                      return ListTile(
                        title: Text(suggestion),
                        onTap: (){
                          // fill the text filed with the trip name.
                          _searchController.text = suggestion;
                          // send the chosen trip to the getTrip function.
                          context.read<SearchCubit>().getTrip(suggestion);
                        },
                      );
                    },
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: const Center(
                  child: Text(
                    'Search for a trip',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 18
                    ),
                  )),
              );
            },
          ),
        ],
      ),
    );
  }
}
