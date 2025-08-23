
// trip model.
class Trip{
  final String title; // trip name.
  final String description; // trip description.
  final String image; // trip image.

  Trip({
    required this.title,
    required this.description,
    required this.image
  });

  // convert to map.
  Map<String, dynamic> toMap (){
    return {
      'title' : title,
      'description' : description,
      'image' : image
    };
  }

  // create from map.
  factory Trip.fromMap (Map<String, dynamic> map){
    return Trip(
      title: map['title'] ?? '',
      description: map['description'] ?? '', 
      image: map['image'] ?? ''
    );
  }
}