class Destination {
  final String name, image;
  final bool popular;

  Destination({required this.name, required this.image, required this.popular});

  factory Destination.fromFirestore(Map<String, dynamic> doc) {
    return Destination(
      name: doc['name'],
      image: doc['image'],
      popular: doc['popular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, "popular": popular};
  }
}
