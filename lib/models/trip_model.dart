
// trip model.
class Trip{
  final String title; // trip name.
  final String description; // trip description.
  final String image; // trip image.
  final String rating; // trip rating.
  final bool? isFavorited;

  Trip({
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    this.isFavorited = false
  });

  // convert to map.
  Map<String, dynamic> toMap (){
    return {
      'title' : title,
      'description' : description,
      'image' : image,
      'rating' : rating,
      'isFavorited' : false
    };
  }

  // create from map.
  factory Trip.fromMap (Map<String, dynamic> map){
    return Trip(
      title: map['title'] ?? '',
      description: map['description'] ?? '', 
      image: map['image'] ?? '',
      rating: map['rating'] ?? '',
      isFavorited: map['isFavorited'] ?? false
    );
  }
}