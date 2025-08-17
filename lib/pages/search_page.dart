import 'package:flutter/material.dart';
import 'package:travel_app/core/colors.dart';

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
            elevation: 0.0,
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
                    color: Colors.grey.shade300
                  )
                ),
                child: IconButton(
                  onPressed: (){}, 
                  icon: Icon(
                    Icons.delete_outlined,
                    color: Colors.brown[300],
                  )
                ),
              )
            ],
            actionsPadding: EdgeInsets.all(16),
          ),

          // body.
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Hello Friend'
              ),
            ),
          )
        ],
      ),
    );
  }
}


