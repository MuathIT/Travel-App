import 'package:flutter/material.dart';

class TripDetailsPage extends StatelessWidget {
  final Map<String, dynamic> trip;
  const TripDetailsPage({super.key, required this.trip});

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
          // trip name.
          trip['title'],
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),

        // rating.
        actions: [
          // star.
          Icon(Icons.star_purple500_sharp, color: Colors.amber),
          const SizedBox(width: 5),
          // rating.
          // Text(
          //   trip['rating'],
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
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
                image: DecorationImage(
                  image: NetworkImage(trip['originalimage']['source']),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // trip description.
            Text(
              trip['extract'],
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
