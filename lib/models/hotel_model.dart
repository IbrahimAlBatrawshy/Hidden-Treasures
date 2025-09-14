class Hotel {
  String imageUrl;
  String name;
  String address;
  double price;
  double rating;
  bool isFavorite;

  Hotel({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });
}

final List<Hotel> featuredHotels = [
  Hotel(
    imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500',
    name: 'The Aston Vill Hotel',
    address: 'Alice Springs NT 0870, Australia',
    price: 200.7,
    rating: 5.0,
    isFavorite: true,
  ),
  Hotel(
    imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
    name: 'Golden Paradise Resort',
    address: 'Northern Territory, Australia',
    price: 175.9,
    rating: 4.8,
    isFavorite: false,
  ),
  Hotel(
    imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500',
    name: 'Luxury Beach Villa',
    address: 'Darwin NT 0800, Australia',
    price: 320.5,
    rating: 4.9,
    isFavorite: false,
  ),
];

final List<Hotel> popularHotels = [
  Hotel(
    imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=300',
    name: 'Asteria Hotel',
    address: 'Wilora NT 0872, Australia',
    price: 165.3,
    rating: 5.0,
    isFavorite: false,
  ),
  Hotel(
    imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300',
    name: 'Ocean View Resort',
    address: 'Katherine NT 0850, Australia',
    price: 189.9,
    rating: 4.7,
    isFavorite: true,
  ),
  Hotel(
    imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=300',
    name: 'Desert Oasis Hotel',
    address: 'Tennant Creek NT 0860, Australia',
    price: 145.2,
    rating: 4.6,
    isFavorite: false,
  ),
];